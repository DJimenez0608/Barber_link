import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:barber_link/Views/new_password/new_password.dart';
import 'package:barber_link/Views/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  //NOMBRE APP
                  Center(
                    child: Text(
                      'BarberLink',
                      style: GoogleFonts.jua(color: Colors.black, fontSize: 60),
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
              CustomFormField(label: 'Usuario', controller: _userController),

              SizedBox(height: 15),

              //CONTRASEÑA
              CustomFormField(
                label: 'Contraseña',
                controller: _passswordController,
              ),

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
                          builder: (context) => const NewPassword(),
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
                label: 'Inisiar sesión',
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.home);
                },
              ),

              //REGISTRAR NUEVA CUENTA
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No tienes cuenta?', style: GoogleFonts.inter()),
                    GestureDetector(
                      child: Text(
                        'Registrate',
                        style: GoogleFonts.inter(color: AppColors().azulMorado),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInView(),
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
                  width: 30,
                  child: Image.asset('assets/Icons/google.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
