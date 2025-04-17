import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // REGISTRO DE USUARIO CORREO/CONTRASEÑA
  Future<void> createUserEmailPassword(
    String email,
    String password,
    String nombre,
    String direccion,
    String celular,
    String tipoUsuario,
  ) async {
    try {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        // Guardar datos adicionales en Firestore
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'nombre': nombre,
          'direccion': direccion,
          'celular': celular,
          'tipoUsuario':
              tipoUsuario, // Guardar el tipo de usuario (cliente o comercio)
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        // Si falla Firestore, elimina al usuario
        await userCredential.user!.delete();
        throw 'Error al guardar los datos en Firestore: $e';
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'La contraseña debe tener al menos 6 caracteres y combinar letras, números o símbolos.';
        case 'email-already-in-use':
          throw 'El correo electrónico ya está registrado. Intenta con otro.';
        case 'invalid-email':
          throw 'El formato del correo electrónico no es válido.';
        default:
          throw 'Ocurrió un error inesperado. Por favor, intenta nuevamente.';
      }
    }
  }

  // LOGIN A UN USUARIO
  Future<void> logInUser(String email, String password) async {
    try {
      // Autenticar al usuario con correo y contraseña
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(
        'Codigo de error: ${e.code}, ${e.message}, ${e.toString()}',
      ); // Imprime el código de error para depuración
      switch (e.code) {
        /*case 'user-not-found':
          throw 'No se encontró un usuario con este correo.';*/
        case 'invalid-credential':
          throw 'El usuario o contraseña es incorrecto/a.';
        case 'invalid-email':
          throw 'El formato del correo electrónico no es válido.';
        case 'user-disabled':
          throw 'La cuenta de este usuario ha sido deshabilitada.';
        default:
          throw 'Ocurrió un error inesperado. Por favor, intenta nuevamente.';
      }
    } catch (e) {
      // Manejo de cualquier otro error inesperado
      throw 'Ocurrió un error al iniciar sesión: $e';
    }
  }

  //LOG OUT UN USUARIO
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw 'Error al cerrar sesión: $e';
    }
  }

  //CAMBIAR CONTRASEÑA
  Future<void> changePassword(String newPassword) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
    } catch (e) {
      throw 'Error al cambiar la contraseña : $e';
    }
  }
}
