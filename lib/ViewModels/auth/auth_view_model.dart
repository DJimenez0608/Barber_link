import 'package:barber_link/Repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // REGISTRAR USUARIO
  Future<void> registerUser(
    String email,
    String password,
    String nombre,
    String direccion,
    String celular,
    String tipoUsuario,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.createUserEmailPassword(
        email,
        password,
        nombre,
        direccion,
        celular,
        tipoUsuario,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString(); // Captura el mensaje detallado
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logInUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Llama al métodod logInUser del AuthRepository para autenticar al usuario
      await _authRepository.logInUser(email, password);
      _errorMessage = null; // Limpia cualquier mensaje de error previo
    } catch (e) {
      _errorMessage = e.toString(); // Captura el mensaje de error
      rethrow; // Lanza el error para manejarlo en la vista
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      await _authRepository.logOut();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await _authRepository.changePassword(newPassword);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authRepository.signInWithGoogle();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
