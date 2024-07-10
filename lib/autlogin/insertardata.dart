import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' as io;

class InsertarDatos{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void guardardatos({
     required io.File imagen,
    required String documento,
    required String nombre,
    required String apellido,
    required String correo,
    required String cargo,
    required String id,

  }) async{
    Reference ref = _storage.ref().child('imagenes/${DateTime.now().toString()}' );
    UploadTask uploadTask =ref.putFile(imagen);
    TaskSnapshot snapshot = await uploadTask;
    String img = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection('users').add({
      'documento': documento,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'imagen': img,
      'cargo': cargo,
      'id': id,
    }).then((value) {
      print('Datos guardados');
    }).catchError((error){
      print('Datos no guardados');
    });
    
  }


}
