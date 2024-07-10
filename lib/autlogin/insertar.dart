import 'package:myapp/autlogin/home.dart';
import 'package:myapp/autlogin/insertardata.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';

class Formulario extends StatefulWidget {
  final String dato;

  const Formulario({Key? key, required this.dato}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final InsertarDatos insertarDatos = InsertarDatos();

  final String defaultimg = 'img/loguito.png';
  io.File? imagen;
  final picker = ImagePicker();

  final frm = GlobalKey<FormState>();
  late String _documento;
  late String _nombre;
  late String _apellido;
  late String _correo;
  late String _cargo;
  late String _id;

  Future<void> obtenerimagen() async {
    final imgurl = await picker.pickImage(source: ImageSource.gallery);
    if (imgurl != null) {
      setState(() {
        imagen = io.File(imgurl.path);
      });
    }
  }

  void guardardatos() async {
    if (imagen != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('imagenes/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(imagen!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String imgURL = await snapshot.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('users').doc(widget.dato).set({
        'documento': _documento,
        'nombre': _nombre,
        'apellido': _apellido,
        'correo': _correo,
        'cargo': _cargo,
        'imagen': imgURL,
        'id': widget.dato,
        'isRegistered': true,  // Este campo indica que el usuario ha completado el formulario
      }).then((value) {
        print('Datos guardados');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Los datos han sido guardados :D')));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              eldocumento: _documento,
              usuario: _nombre,
              elapellido: _apellido,
              imagenUrl: imgURL,
              elcorreo: _correo,
              cargo: _cargo,
            ),
          ),
        );
      }).catchError((error) {
        print('Los datos no se pudieron guardar');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Los datos no han sido guardados :(')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: frm,
              child: Column(
                children: [
                  Center(
                    child: imagen != null
                        ? Image.file(imagen!)
                        : Image.asset(
                            defaultimg,
                            height: 200,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: obtenerimagen,
                    child: Text(
                      'Seleccionar imagen',
                      style: TextStyle(
                        color: Color(0xFF14A60F),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Color(0xFF14A60F)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Documento',
                        contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Color(0xFF14A60F)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el doc';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _documento = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Color(0xFF14A60F)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Color(0xFF14A60F)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _nombre = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Color(0xFF14A60F)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Apellido',
                        contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Color(0xFF14A60F)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el apellido';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _apellido = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Color(0xFF14A60F)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Color(0xFF14A60F)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el correo electrónico';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _correo = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Color(0xFF14A60F)),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cargo',
                        contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Color(0xFF14A60F)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el cargo';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _cargo = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (frm.currentState!.validate()) {
                        frm.currentState!.save();
                        guardardatos(); // Llamar a guardardatos() después de validar el formulario
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      backgroundColor: Color(0xFF14A60F),
                    ),
                    child: Text(
                      'Registrate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
