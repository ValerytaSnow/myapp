import 'package:flutter/material.dart';
import 'package:myapp/listados/pueblos.dart';
import 'package:myapp/listados/listmap.dart';


class Listados extends StatefulWidget {
  const Listados({super.key});

  @override
  State<Listados> createState()=> _ListadosState();
}

class _ListadosState extends State<Listados> {
  @override
    Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        title: const Text('Pueblos del mundo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        ),

      ),
      body: ListView.builder(
        itemCount:pueblosColombia.length,
        itemBuilder: (context,index){
          return Padding(padding: EdgeInsets.all(10),
          child: Card(
            elevation: 6.0,
            color: Colors.deepPurpleAccent,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: (
                  NetworkImage(
                    pueblosmun[index]['urlImagen']
                  )
                ),
              ),
              title: Text(pueblosmun[index]['nombre']),
              subtitle: Text(pueblosmun[index]['datoCurioso']),
              trailing: Icon(Icons.arrow_circle_down_sharp),
              onTap:(){
                showModalBottomSheet(context: context, builder:(context){
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: Text('Pueblo del mundo'),
                    ),
                    body: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end:Alignment.bottomCenter,
                          colors: [
                            Colors.greenAccent,
                            Colors.lightGreenAccent,
                          ]
                        )
                      ),
                      child: ListView(
                        children: [
                          Container(
                            width: 120,
                            height: 250,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  pueblosmun[index]['urlImagen']

                                ),
                                ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(8.0),
                          child: Text(pueblosmun[index]['datoCurioso'],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            ),
                            ),
                            ),
                        ],
                      ),
                    ),
                  );

                }
                );
              },
            ),
          ),
          );














































































































        }
        ),
      
    
    
    
      ),
      );
}
}

