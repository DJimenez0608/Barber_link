import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
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

              //FORMS
              //USUARIO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().azulMorado),
                    ),
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: AppColors().negro),
                    border: OutlineInputBorder(),
                  ),
                  controller: _userController,
                ),
              ),

              SizedBox(height: 15),

              //CONTRASEÑA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().azulMorado),
                    ),
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: AppColors().negro),
                    border: OutlineInputBorder(),
                  ),
                  controller: _passswordController,
                ),
              ),

              //RESTAURAR CONTRASEÑA
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text('Olvide la contraseña'),
                    onTap: () {},
                  ),
                  SizedBox(width: 25),
                ],
              ),

              SizedBox(height: 40),

              //BOTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  backgroundColor: AppColors().azulMorado,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                },
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: AppColors().blanco, fontSize: 17),
                ),
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
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //INICIAR SESION CON GOOGLE
              InkWell(
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
