import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String nombre;
  String imagen;

  UserModel({required this.nombre, required this.imagen});

  void updateUser(String newNombre, String newImagen) {
    nombre = newNombre;
    imagen = newImagen;
    notifyListeners(); // Notifica a los oyentes (como los widgets) que los datos han cambiado
  }
}
