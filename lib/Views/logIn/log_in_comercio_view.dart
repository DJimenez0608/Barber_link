// lib/Views/logIn/log_in_comercio_view.dart
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
// import 'package:flutter_easy_recaptcha_v2/flutter_easy_recaptcha_v2.dart'; // Eliminado

class LogInComercioView extends StatefulWidget {
  const LogInComercioView({Key? key}) : super(key: key);

  @override
  _LogInComercioViewState createState() => _LogInComercioViewState();
}

class _LogInComercioViewState extends State<LogInComercioView> {
  final TextEditingController _emailNitController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Se mantiene para validación de campos

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
         title: Text('Login Comercio', style: TextStyle(color: AppColors().blanco)),
         centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible( 
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Text(
                        'Ingresa para Gestionar tu Negocio',
                        style: GoogleFonts.jua(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        controller: _emailNitController,
                        label: 'Email or NIT',
                        obscureText: false,
                        // validator se elimina ya que CustomFormField no lo tendrá
                      ),
                      const SizedBox(height: 12),
                      CustomFormField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true, // El widget CustomFormField maneja la visibilidad
                        // validator se elimina
                      ),
                    ],
                  ),
                ),
              ),
              
              // Espacio donde estaba el reCAPTCHA, ahora eliminado
              const SizedBox(height: 20), 
              
              Boton(
                onTap: () {
                  // Validar campos manualmente si es necesario, o usar _formKey si se mantiene
                  // if (_formKey.currentState?.validate() ?? false) { 
                  //   _attemptLogin(authViewModel);
                  // }
                  // Por ahora, se intenta el login directamente si los campos no están vacíos
                  if (_emailNitController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                     _attemptLogin(authViewModel);
                  } else {
                    _showError('Por favor, completa todos los campos.');
                  }
                },
                label: authViewModel.isLoading ? 'Ingresando...' : 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _attemptLogin(AuthViewModel authViewModel) {
    final emailNit = _emailNitController.text.trim();
    final password = _passwordController.text.trim();

    // Llamar al método de login estándar
    authViewModel
        .logInUser(emailNit, password)
        .then((_) {
      if (mounted && authViewModel.errorMessage == null) {
        // Asumiendo que tienes una ruta definida para el home del comercio
        Navigator.pushReplacementNamed(context, '/homeComerce'); 
      } else if (mounted && authViewModel.errorMessage != null) {
        _showError(authViewModel.errorMessage!);
      }
    }).catchError((error) {
      if (mounted) {
         _showError(error.toString());
      }
    });
  }

  void _showError(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error de Inicio de Sesión'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailNitController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
