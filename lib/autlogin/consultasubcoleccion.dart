import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PantallaSubcoleccion extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  PantallaSubcoleccion({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subcollection'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
              MaterialPageRoute(
                builder: (context) => DetallesSubcoleccion(
                detalleSubcoleccion : data[index],
              ),
              ),
              );
            },
            child: Card(
              child: ListTile(
                 title: Text(data[index]['dato']),
              ),
            ),
          );
        }),
    );
  }
}
class DetallesSubcoleccion extends StatelessWidget {
    final Map<String, dynamic> detalleSubcoleccion;
    DetallesSubcoleccion({required this.detalleSubcoleccion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detalles de los elementos'),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detalles de los elementos de la subcoleccion:'),
            Text('Nombre: ${detalleSubcoleccion['pri']}'),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
            Icons.star,
                color: Colors.amber,
                ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
             
          ],
        )),
    );
  }
}