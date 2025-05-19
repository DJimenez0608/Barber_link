import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barber_link/Models/usuario.dart';
import 'package:barber_link/Models/serviciosComercio.dart';

class ClientViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lista de todos los comercios
  List<UserModel> _allCommerces = [];
  List<UserModel> get allCommerces => _allCommerces;

  // Lista de comercios filtrados por búsqueda
  List<UserModel> _filteredCommerces = [];
  List<UserModel> get filteredCommerces => _filteredCommerces;

  // Lista de servicios para el comercio seleccionado
  List<ServiciosComercio> _servicesForSelectedCommerce = [];
  List<ServiciosComercio> get servicesForSelectedCommerce => _servicesForSelectedCommerce;
  
  // Lista de servicios filtrados para el comercio seleccionado
  List<ServiciosComercio> _filteredServicesForSelectedCommerce = [];
  List<ServiciosComercio> get filteredServicesForSelectedCommerce => _filteredServicesForSelectedCommerce;


  // Comercio actualmente seleccionado
  UserModel? _selectedCommerce;
  UserModel? get selectedCommerce => _selectedCommerce;

  // Estados de carga
  bool _isLoadingCommerces = false;
  bool get isLoadingCommerces => _isLoadingCommerces;

  bool _isLoadingServices = false;
  bool get isLoadingServices => _isLoadingServices;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Término de búsqueda para comercios
  String _commerceSearchTerm = '';

  // Término de búsqueda para servicios
  String _serviceSearchTerm = '';


  ClientViewModel() {
    fetchCommerces();
  }

  // Obtener todos los comercios
  Future<void> fetchCommerces() async {
    _isLoadingCommerces = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('tipoUsuario', isEqualTo: 'comercio')
          .get();

      _allCommerces = querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.id, doc.data()))
          .toList();
      _filteredCommerces = List.from(_allCommerces); // Inicialmente, todos los comercios están filtrados
      
      _isLoadingCommerces = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error al cargar los comercios: ${e.toString()}";
      _isLoadingCommerces = false;
      print(_errorMessage);
      notifyListeners();
    }
  }

  // Seleccionar un comercio y obtener sus servicios
  void selectCommerce(UserModel commerce) {
    _selectedCommerce = commerce;
    notifyListeners(); // Notificar que el comercio seleccionado ha cambiado
    fetchServicesForCommerce(commerce.id);
  }

  // Obtener servicios para un comercio específico
  Future<void> fetchServicesForCommerce(String commerceId) async {
    if (_selectedCommerce == null || _selectedCommerce!.id != commerceId) {
      // Si el comercio seleccionado no coincide, busca el comercio primero
      // Esto es un fallback, idealmente selectCommerce ya fue llamado.
      final commerceDoc = await _firestore.collection('users').doc(commerceId).get();
      if (commerceDoc.exists) {
        _selectedCommerce = UserModel.fromFirestore(commerceDoc.id, commerceDoc.data()!);
      } else {
        _errorMessage = "Comercio no encontrado.";
        _isLoadingServices = false;
        notifyListeners();
        return;
      }
    }

    _isLoadingServices = true;
    _errorMessage = null;
    _serviceSearchTerm = ''; // Resetear búsqueda de servicios al cambiar de comercio
    notifyListeners();

    try {
      final querySnapshot = await _firestore
          .collection('services')
          .where('comercioId', isEqualTo: commerceId)
          .get();

      _servicesForSelectedCommerce = querySnapshot.docs
          .map((doc) => ServiciosComercio.fromFirestore(doc.id, doc.data()))
          .toList();
      _filteredServicesForSelectedCommerce = List.from(_servicesForSelectedCommerce);

      _isLoadingServices = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error al cargar los servicios del comercio: ${e.toString()}";
      _isLoadingServices = false;
      print(_errorMessage);
      notifyListeners();
    }
  }

  // Filtrar la lista de comercios
  void filterCommerces(String searchTerm) {
    _commerceSearchTerm = searchTerm.toLowerCase();
    if (_commerceSearchTerm.isEmpty) {
      _filteredCommerces = List.from(_allCommerces);
    } else {
      _filteredCommerces = _allCommerces
          .where((commerce) =>
              commerce.nombre?.toLowerCase().contains(_commerceSearchTerm) ?? false)
          .toList();
    }
    notifyListeners();
  }

    // Filtrar la lista de servicios para el comercio seleccionado
  void filterServices(String searchTerm) {
    _serviceSearchTerm = searchTerm.toLowerCase();
    if (_serviceSearchTerm.isEmpty) {
      _filteredServicesForSelectedCommerce = List.from(_servicesForSelectedCommerce);
    } else {
      _filteredServicesForSelectedCommerce = _servicesForSelectedCommerce
          .where((service) =>
              service.nombre?.toLowerCase().contains(_serviceSearchTerm) ?? false)
          .toList();
    }
    notifyListeners();
  }

  void clearSelectedCommerceAndServices() {
    _selectedCommerce = null;
    _servicesForSelectedCommerce = [];
    _filteredServicesForSelectedCommerce = [];
    _serviceSearchTerm = '';
    notifyListeners();
  }
}
