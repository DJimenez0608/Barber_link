import 'package:barber_link/Models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeAdminComerceViewModel extends ChangeNotifier {
  final List<UserModel> _commerces = [];
  List<UserModel> filteredCommerces = [];

  HomeAdminComerceViewModel() {
    fetchCommerces();
  }

  // Obtener comercios desde Firestore
  Future<void> fetchCommerces() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('tipoUsuario', isEqualTo: 'comercio')
          .get();

      _commerces.clear();
      for (var doc in querySnapshot.docs) {
        _commerces.add(UserModel.fromFirestore(doc.id, doc.data()));
      }
      filteredCommerces = List.from(_commerces);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al obtener comercios: $e');
    }
  }

  // Filtrar comercios por nombre
  void filterCommerces(String query) {
    if (query.isEmpty) {
      filteredCommerces = List.from(_commerces);
    } else {
      filteredCommerces = _commerces
          .where((commerce) =>
              commerce.nombre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Eliminar comercio
  Future<void> deleteCommerce(String commerceId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(commerceId).delete();
      _commerces.removeWhere((commerce) => commerce.id == commerceId);
      filteredCommerces.removeWhere((commerce) => commerce.id == commerceId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar comercio: $e');
    }
  }
}