import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;
  //REGISTRO DE USUARIO CORREO/CONTRASEÑA
  Future<void> createUserEmailPassword(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  //LOGIN A UN USUARIO
  Future<void> logInUser(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
