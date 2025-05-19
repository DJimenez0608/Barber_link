import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http; // Eliminado
// import 'dart:convert'; // Eliminado

class AuthRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> createUserEmailPassword(
    String email,
    String password,
    String nombre,
    String direccion,
    String celular,
    String tipoUsuario,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'nombre': nombre,
        'direccion': direccion,
        'celular': celular,
        'tipoUsuario': tipoUsuario,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'La contraseña debe tener al menos 6 caracteres y combinar letras, números o símbolos.';
        case 'email-already-in-use':
          throw 'El correo electrónico ya está registrado. Intenta con otro.';
        case 'invalid-email':
          throw 'El formato del correo electrónico no es válido.';
        default:
          throw 'Ocurrió un error inesperado durante el registro. Por favor, intenta nuevamente.';
      }
    } catch (e) {
        // Si Firestore falla después de crear el usuario en Auth, intenta eliminar el usuario de Auth.
        User? currentUser = auth.currentUser;
        if (currentUser != null && currentUser.email == email) {
          await currentUser.delete().catchError((deleteError) {
            print("Error al intentar eliminar usuario de Auth tras fallo de Firestore: $deleteError");
          });
        }
        throw 'Error al guardar los datos en Firestore: $e';
    }
  }

  Future<void> logInUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Codigo de error Firebase Auth (login normal): ${e.code}, ${e.message}');
      switch (e.code) {
        case 'invalid-credential':
          throw 'El usuario o contraseña es incorrecto/a.';
        case 'invalid-email':
          throw 'El formato del correo electrónico no es válido.';
        case 'user-disabled':
          throw 'La cuenta de este usuario ha sido deshabilitada.';
        default:
          throw 'Ocurrió un error inesperado al iniciar sesión. Por favor, intenta nuevamente.';
      }
    } catch (e) {
      throw 'Ocurrió un error al iniciar sesión: $e';
    }
  }

  // El método logInUserWithRecaptcha ha sido eliminado.

  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut(); 
      await auth.signOut();
    } catch (e) {
      throw 'Error al cerrar sesión: $e';
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
      } else {
        throw 'No hay un usuario actualmente autenticado para cambiar la contraseña.';
      }
    } on FirebaseAuthException catch (e) {
      throw 'Error al cambiar la contraseña: ${e.message} (código: ${e.code})';
    } catch (e) {
      throw 'Error al cambiar la contraseña: $e';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // El usuario canceló el flujo de inicio de sesión
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw 'No se pudieron obtener los tokens de Google.';
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await auth.signInWithCredential(credential);
    } catch (e) {
      throw 'Error al iniciar sesión con Google: $e';
    }
  }
}
