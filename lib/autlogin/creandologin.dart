import 'package:flutter/material.dart';
import 'package:myapp/autlogin/creandoregistrousuariometlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/autlogin/insertar.dart';
import 'package:myapp/autlogin/recuperacioncontrasena.dart';
import 'package:myapp/autlogin/home.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  RegistroUsuarioLogin mial = RegistroUsuarioLogin();
  final _formKey = GlobalKey<FormState>();
  late String _emailController;
  late String _passwordController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('img/loguito.png'),
                    ),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                        _emailController = value!;
                      },
                    ),
                  ),
                        ],
                      ),
                    ),

               SizedBox(height: 16.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Color(0xFF14A60F)),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Color(0xFF14A60F)),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      _passwordController = value;
                    },
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese la contraseña';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _passwordController = value!;
                    },
                  ),
                ),
                    SizedBox(height: 15,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RecuperarContrasena()));
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: Color(0xFF401201),fontSize: 16),
                      ),
                    ),
                    
                    SizedBox(height: 15,),

                   ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        String dato = await mial.loginUsuario(_emailController, _passwordController);
                        print('hola $dato');
                        if (dato == "1") {    
                          print('nivel de seguridad devil');              
                        } else if (dato == "2") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario y contraseña registrados')));
                        } else if(dato!=""){
                          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(dato).get();
                          if (userDoc.exists && userDoc['isRegistered'] == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(
                                  eldocumento: userDoc['documento'],
                                  usuario: userDoc['nombre'],
                                  elapellido: userDoc['apellido'],
                                  elcorreo: userDoc['correo'],
                                  imagenUrl: userDoc['imagen'],
                                  cargo: userDoc['cargo'],
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Formulario(dato: dato)));
                          }
                        } else {
                          print('eeeeeee');
                        }
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
                        'Ingresar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
