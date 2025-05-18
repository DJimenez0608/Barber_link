// ... imports ...
 import 'package:barber_link/Routes/routes.dart';
 import 'package:barber_link/Theme/app_colors.dart';
 import 'package:barber_link/Views/Widgets/boton.dart';
 import 'package:barber_link/Views/Widgets/form_field.dart';
 import 'package:barber_link/Views/password/new_password_view.dart';
 import 'package:barber_link/Views/sign_in/select_type_user.dart';
 import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
 import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:provider/provider.dart';
 

 class LogInView extends StatefulWidget {
  const LogInView({super.key});
 

  @override
  State<LogInView> createState() => _LogInViewState();
 }
 

 class _LogInViewState extends State<LogInView> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

  Future<void> _logInUser(AuthViewModel authVM) async {
    final email = _userController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Por favor, completa todos los campos. ');
      return;
    } 

    try {
      await authVM.logInUser(email, password);
      if (!mounted) return;
      // Obtener el UID del usuario autenticado
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorDialog('No se pudo obtener la información del usuario. ');
        return;
      }

      // Consulta Firestore para obtener el tipo de usuario
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (!userDoc.exists) {
        _showErrorDialog(
          'No se encontró información del usuario en la base de datos. ',
        );
        return;
      }

      final tipoUsuario = userDoc.data()?['tipoUsuario'] ?? '';

      // Redirige a la pantalla correspondiente según el tipo de usuario
      if (tipoUsuario == 'cliente') {
        Navigator.pushReplacementNamed(context, Routes.home);
        //Navigator.pushReplacementNamed(context, Routes.homeClient);
      } else if (tipoUsuario == 'comercio') {
        Navigator.pushReplacementNamed(context, Routes.homeComerce);
        //Navigator.pushReplacementNamed(context, Route.homeComerce);
      } else if (tipoUsuario == 'administrador') {
        Navigator.pushReplacementNamed(context, Routes.homeAdmin);
      } else {
        _showErrorDialog('Tipo de usuario desconocido.');
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  } 

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
 

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      //NOMBRE APPq4
                      Center(
                        child: Text(
                          'BarberLink',
                          style: GoogleFonts.jua(
                            color: Colors.black,
                            fontSize: 60,
                          ),
                        ),
                      ), 

                      //IMAGEN BIGOTE
                      Image.asset(
                        'assets/Images/bigote.png',
                        height: 260,
                        width: 370,
                      ),
                    ],
                  ),

                  //FRASE DE LA MARCA
                  Center(
                    child: Text(
                      'Te conectamos con tu estilo',
                      style: GoogleFonts.islandMoments(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //FORMS
                  //USUARIO
                  CustomFormField(
                    label: 'Usuario',
                    controller: _userController,
                    obscureText: false,
                  ),

                  SizedBox(height: 15),

                  //CONTRASEÑA
                  CustomFormField(
                    label: 'Contraseña',
                    controller: _passwordController,
                  ),
                  SizedBox(height: 15),

                  //RESTAURAR CONTRASEÑA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          'Olvidé la contraseña',
                          style: TextStyle(color: AppColors().azulMorado),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewPasswordView(),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 25),
                    ],
                  ),

                  SizedBox(height: 40),

                  //BUTTON
                  Boton(
                    label: authVM.isLoading ? 'Cargando... ' : 'Iniciar sesión',
                    onTap: authVM.isLoading ? null : () => _logInUser(authVM),
                  ),
                  SizedBox(height: 20),
                  Boton(
                    label: 'Iniciar sesión como comercio',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.logInComercio);
                    },
                  ),
 

                  //REGISTRAR NUEVA CUENTA
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('¿No tienes cuenta?', style: GoogleFonts.inter()),
                        GestureDetector(
                          child: Text(
                            'Registrate',
                            style: GoogleFonts.inter(
                              color: AppColors().azulMorado,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const SelectRegisterTypeView(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //INICIAR SESION CON GOOGLE
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      height: 30,
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Image.asset('assets/Icons/google.png'),
                            onTap: () async {
                              final provider = context.read<AuthViewModel>();
                              await provider.signInWithGoogle();
                              print(
                                '---------------------------------------------------------${provider.errorMessage}',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                          Image.asset('assets/Icons/FaceebookLogo.png'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 }