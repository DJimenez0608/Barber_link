import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

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
        // Esto es una medida de limpieza, aunque puede fallar si el usuario actual ya no es el que se acaba de crear.
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

  Future<void> logInUserWithRecaptcha(String email, String password, String recaptchaToken) async {
    try {
      // --- COLOCA LA URL DE TU FIREBASE FUNCTION AQUÍ ---
      const String functionsUrl = 'TU_URL_DE_FIREBASE_FUNCTION_VERIFYRECAPTCHA'; // ¡¡¡REEMPLAZA ESTO!!!
      // -------------------------------------------------
      
      if (functionsUrl == 'TU_URL_DE_FIREBASE_FUNCTION_VERIFYRECAPTCHA') {
          throw Exception("Configuración pendiente: Debes reemplazar 'TU_URL_DE_FIREBASE_FUNCTION_VERIFYRECAPTCHA' en AuthRepository con la URL real de tu Firebase Function.");
      }

      final verificationUrl = Uri.parse(functionsUrl);
      
      final response = await http.post(
        verificationUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': recaptchaToken}),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success'] == true) {
          await auth.signInWithEmailAndPassword(email: email, password: password);
        } else {
          final errorCodes = responseBody['error-codes']?.toString() ?? 'sin detalles';
          print('Error de verificación de reCAPTCHA en backend: $errorCodes');
          throw 'La verificación "No soy un robot" falló. ($errorCodes). Intenta de nuevo.';
        }
      } else {
        print('Error del servidor al verificar reCAPTCHA: ${response.statusCode} ${response.body}');
        throw 'Error al conectar con el servidor para la verificación (${response.statusCode}). Intenta más tarde.';
      }
    } on FirebaseAuthException catch (e) {
      print('Codigo de error Firebase Auth (login con reCAPTCHA): ${e.code}, ${e.message}');
      switch (e.code) {
        case 'invalid-credential':
          throw 'El usuario o contraseña es incorrecto/a.';
        case 'invalid-email':
          throw 'El formato del correo electrónico no es válido.';
        case 'user-disabled':
          throw 'La cuenta de este usuario ha sido deshabilitada.';
        default:
          throw 'Ocurrió un error inesperado durante el inicio de sesión. Por favor, intenta nuevamente.';
      }
    } catch (e) {
      print('Error en logInUserWithRecaptcha: $e');
      throw e.toString(); 
    }
  }

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