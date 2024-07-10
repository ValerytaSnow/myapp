import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/autlogin/datocliente.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<QuerySnapshot> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getData();
  }

  Future<QuerySnapshot> getData() async {
    return FirebaseFirestore.instance.collection('users').get();
    
    }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicacón flutter'),
      ),
      body: FutureBuilder(
        future: _futureData,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error }'));
             }else{
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  Map<String,dynamic>data = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> Datoscliente(data: data)),
                      );

                    },
                    child: ExpansionTile(
                     title: Text(data['nombre']),
                      subtitle: Text(data['correo']),
                      children:[
                        Text('Documento: ${data['documento']}'),
                        Text('Apellido: ${data['apellido']}'),

                      ],
                    ),
                  );
                  
                },
                
              );
            }
      
          },
        ),

      );
    }
}