import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/autlogin/consultasubcoleccion.dart';

class ConsultaPorPares extends StatefulWidget {
  @override
  _ConsultaPorParesState createState() => _ConsultaPorParesState();
}

class _ConsultaPorParesState extends State<ConsultaPorPares> {
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  Map<String,dynamic>data = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                  return GestureDetector(
                    onTap: () async{
                      DocumentReference clienteRef = snapshot.data!.docs[index].reference;
                      CollectionReference subcoleccionRef = clienteRef.collection('pri');
                      QuerySnapshot subcoleccionSnapshot = await subcoleccionRef.get();
                      List<Map<String, dynamic>> subcoleccionData = subcoleccionSnapshot.docs.map((doc) => doc.data() as Map <String, dynamic>).toList();
                      Navigator.push(
                        context,
                      MaterialPageRoute(builder: (context)=> PantallaSubcoleccion(data: subcoleccionData)),
                      );

                    },
                    child: Card(
                      child: ListTile(
                        title: Text(data['nombre']),
                      ),
                    )
                  );
                },
              );
            }
      
          },
        ),

      );
    }
}