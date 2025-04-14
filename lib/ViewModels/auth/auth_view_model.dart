import 'package:barber_link/Repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // REGISTRAR USUARIO
  Future<void> registerUser(String email, String password, String nombre, String direccion, String celular, String tipoUsuario) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.createUserEmailPassword(email, password, nombre, direccion, celular, tipoUsuario);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString(); // Captura el mensaje detallado
    }

    _isLoading = false;
    notifyListeners();
  }
}
