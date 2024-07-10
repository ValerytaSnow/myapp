import 'package:flutter/material.dart';
import 'package:myapp/autlogin/creandoregistrousuariometlogin.dart';
import 'package:myapp/autlogin/crearhuellapage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegistroUsuarioLogin mial = RegistroUsuarioLogin();

  final _formKey = GlobalKey<FormState>();
  late String _emailController;
  late String _passwordController;
  late String _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF401201),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('img/loguito.png'),
                ),
                SizedBox(height: 20,),
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
                        return 'Ingrese el email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _emailController = value!;
                    },
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
                SizedBox(height: 16.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Color(0xFF14A60F)),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      contentPadding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Color(0xFF14A60F)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme la contraseña';
                      } else if (value != _passwordController) {
                        return 'Las contraseñas no coinciden';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _confirmPasswordController = value!;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (_passwordController != _confirmPasswordController) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Las contraseñas no coinciden'),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        var dato = mial.registroUsuario(_emailController, _passwordController);
                        if (dato == 1) {
                          print('Nivel de seguridad débil');
                        } else if (dato == 2) {
                          print('Email ya registrado.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email ya registrado :D')));
                        } else if (dato != null) {
                          print('Usuario registrado.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario registrado :D')));
                          // Navigator.pop(context);
                        }
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
                    'Registrarse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Huella()),
                    );
                  },
                  child: Text(
                    'Crear Huella Digital',
                    style: TextStyle(
                      color: Color(0xFF14A60F),
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
    );
  }
}
 