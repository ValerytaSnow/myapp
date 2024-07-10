import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myapp/autlogin/conexion.dart';
import 'package:myapp/autlogin/creandologin.dart';
import 'package:myapp/autlogin/creandousuariologin.dart';
import 'package:myapp/autlogin/insertar.dart';
import 'package:myapp/autlogin/screen.dart';
/*import 'package:myapp/vista/pueblosdelmundo.dart';*/

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('img/recycle.json'), 
      nextScreen: EcoSystemApp(),
      duration: 4000,
      splashIconSize: 600,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: Duration(seconds: 2),
      );
  }
}