import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barber_link/Models/usuario.dart';
import 'package:flutter/material.dart';

class HomeAdminViewModel extends ChangeNotifier {
  // Propiedad para manejar el índice seleccionado en la barra de navegación
  int _selectedIndex = 1; // Casa como pantalla inicial
  int get selectedIndex => _selectedIndex;

  // Método para actualizar el índice seleccionado
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notifica a los widgets que dependen de este ViewModel
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  // Método para obtener los datos del usuario desde Firestore
  Future<UserModel?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users') // Asegúrate de que el nombre de la colección sea correcto
          .doc(user.uid)
          .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc.data()!);
      }
    } catch (e) {
      print('Error al obtener datos del usuario: $e');
    }

    return null;
  }
}