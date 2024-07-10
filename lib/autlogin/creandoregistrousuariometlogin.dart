import 'package:firebase_auth/firebase_auth.dart';


class RegistroUsuarioLogin{
  final FirebaseAuth _fa = FirebaseAuth.instance;

  //si no se ha registrado

  Future registroUsuario(String correo, String pass) async{
    //otro tipo de if

    try{
      UserCredential uc = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: correo, password: pass);
      print(uc.user);
      return(uc.user);
    }


    on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        print('EL PASSWORD');
        return 1;
      }
      else if(e.code == 'email-already-in-use'){
        print('Ya que existe');
        return 2;
      }
    }
  }

  Future loginUsuario(String correo, String passw) async{
    if(correo.isNotEmpty && passw.isNotEmpty){
      try{
        UserCredential  uc = await _fa.signInWithEmailAndPassword(
          email: correo, password: passw);
          final u = uc.user;

          if (u != null){
            return u.uid;//auternticacion exitosa
          }

      }on FirebaseAuthException catch(e){
        print('error de autenticacion: ${e.code}');

        if (e.code == 'user-not-found' || e.code == 'wrong-password'){
          return "1";//usuario  y contra incorrectos
        }
      }catch (e){
        print('error: $e');
      }
    }
    else{
      print('correo y contraseña no pueden estar vacios');
       return "1";
    }

  }
}

