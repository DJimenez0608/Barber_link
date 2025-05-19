// lib/ViewModels/admin/membership_view_model.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barber_link/Models/membership_model.dart';

class MembershipViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'memberships'; // Nombre de la colección en Firestore

  List<MembershipModel> _memberships = [];
  List<MembershipModel> get memberships => _memberships;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MembershipViewModel() {
    fetchMemberships();
  }

  // Obtener todas las membresías
  Future<void> fetchMemberships() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final querySnapshot = await _firestore.collection(_collectionPath).orderBy('createdAt', descending: true).get();
      _memberships = querySnapshot.docs
          .map((doc) => MembershipModel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } catch (e) {
      _errorMessage = "Error al cargar membresías: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Agregar una nueva membresía
  Future<bool> addMembership(MembershipModel membership) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestore.collection(_collectionPath).add(membership.toFirestore());
      await fetchMemberships(); // Recargar la lista después de agregar
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Error al agregar membresía: ${e.toString()}";
      print(_errorMessage);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Actualizar una membresía existente
  Future<bool> updateMembership(MembershipModel membership) async {
    if (membership.id == null) {
      _errorMessage = "Error: ID de membresía no puede ser nulo para actualizar.";
      notifyListeners();
      return false;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestore.collection(_collectionPath).doc(membership.id).update(membership.toFirestore());
      await fetchMemberships(); // Recargar la lista después de actualizar
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Error al actualizar membresía: ${e.toString()}";
      print(_errorMessage);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Eliminar una membresía (Opcional, pero útil)
  Future<bool> deleteMembership(String membershipId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestore.collection(_collectionPath).doc(membershipId).delete();
      await fetchMemberships(); // Recargar la lista
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Error al eliminar membresía: ${e.toString()}";
      print(_errorMessage);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Limpiar mensaje de error
  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}
