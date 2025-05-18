// lib/Views/logIn/log_in_comercio_view.dart
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:flutter_easy_recaptcha_v2/flutter_easy_recaptcha_v2.dart'; // Usando el widget de tu paquete

class LogInComercioView extends StatefulWidget {
  const LogInComercioView({Key? key}) : super(key: key);

  @override
  _LogInComercioViewState createState() => _LogInComercioViewState();
}

class _LogInComercioViewState extends State<LogInComercioView> {
  final TextEditingController _emailNitController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _captchaToken;
  final _formKey = GlobalKey<FormState>();
  final String siteKey = '6Lc2gT0rAAAAALqcKOg4m7JXyYLAS2_MxXVG56Dr';
  Key _recaptchaWidgetKey = UniqueKey(); // Para forzar la reconstrucción del widget

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
          child: Column( // Este Column es el principal de la pantalla
            mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente el contenido
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Parte superior con campos de texto, podría ser desplazable si es necesario
              // Si los campos de texto son muchos, envuelve ESTA PARTE en un Flexible + SingleChildScrollView
              Flexible( // Permite que esta sección tome espacio pero no infinito si hay otros Flexible/Expanded
                // También podrías quitar Flexible y dejar que el Column se ajuste al contenido,
                // si el contenido no es demasiado alto para la pantalla.
                // Si los campos son pocos, puedes quitar Flexible y SingleChildScrollView de aquí.
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
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Por favor ingresa tu Email o NIT';
                          bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                          bool isNit = RegExp(r"^[0-9]+([0-9-]*[0-9kK])?$").hasMatch(value);
                          if (!isValidEmail && !isNit) return 'Ingresa un Email o NIT válido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomFormField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Por favor ingresa tu contraseña';
                          if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20), // Espacio entre los campos y el reCAPTCHA

              // --- WIDGET RECAPTCHA CON TAMAÑO FIJO ---
              Center(
                child: SizedBox(
                  key: _recaptchaWidgetKey, // Aplicar la clave aquí
                  width: 304,  // Ancho estándar del reCAPTCHA de Google
                  height: 78, // Altura estándar del reCAPTCHA de Google (compacto)
                  child: RecaptchaV2(
                    apiKey: siteKey,
                    onVerifiedSuccessfully: (String token) {
                      setState(() {
                        _captchaToken = token;
                      });
                      print('Token de reCAPTCHA (onVerifiedSuccessfully): $token');
                    },
                    // Si el widget RecaptchaV2 internamente muestra un indicador de carga,
                    // no necesitamos añadir otro aquí.
                  ),
                ),
              ),
              // --- FIN WIDGET RECAPTCHA ---
              
              const SizedBox(height: 20), // Espacio entre reCAPTCHA y el botón
              Boton(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                      if (_captchaToken == null) {
                          _showError('Por favor, completa la verificación "No soy un robot".');
                          // Intentar refrescar el widget RecaptchaV2 cambiando su clave
                          setState(() {
                            _recaptchaWidgetKey = UniqueKey();
                          });
                          return;
                      }
                      _attemptLogin(authViewModel);
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

    authViewModel
        .logInUserWithRecaptcha(emailNit, password, _captchaToken!)
        .then((_) {
      if (mounted && authViewModel.errorMessage == null) {
        Navigator.pushReplacementNamed(context, '/homeComerce');
      }
    }).catchError((error) {
      if (mounted) {
         _showError(error.toString());
      }
      setState(() {
        _captchaToken = null;
        _recaptchaWidgetKey = UniqueKey(); // Refrescar al fallar el login también
      });
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