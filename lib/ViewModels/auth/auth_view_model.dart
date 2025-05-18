import 'package:barber_link/Repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
  }

  Future<void> registerUser(
    String email,
    String password,
    String nombre,
    String direccion,
    String celular,
    String tipoUsuario,
  ) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.createUserEmailPassword(
        email,
        password,
        nombre,
        direccion,
        celular,
        tipoUsuario,
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logInUser(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.logInUser(email, password);
    } catch (e) {
      _setError(e.toString());
      rethrow; 
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logInUserWithRecaptcha(String email, String password, String recaptchaToken) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.logInUserWithRecaptcha(email, password, recaptchaToken);
    } catch (e) {
      _setError(e.toString());
      rethrow; 
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logOut() async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.logOut();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> changePassword(String newPassword) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.changePassword(newPassword);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}