import 'package:myapp/autlogin/conexion.dart';
import 'package:myapp/autlogin/datocliente.dart';
import 'package:myapp/autlogin/home.dart';
import 'package:myapp/listados/consultaparejas.dart';
import 'package:myapp/vista/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/autlogin/firebase_options.dart';
import 'package:myapp/autlogin/creandologin.dart';
import 'package:myapp/autlogin/creandousuariologin.dart';
import 'package:myapp/autlogin/insertar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/autlogin/actualizaratributo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
//stls
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase Demo',
      home: Splash(),
      
    );
  }
}

