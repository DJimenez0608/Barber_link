import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRegisterTypeView extends StatelessWidget {
  const SelectRegisterTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: Text(
          'Selecciona tu tipo de cuenta',
          style: TextStyle(color: AppColors().blanco),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título descriptivo
              Text(
                '¿Cómo deseas registrarte?',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors().azulMorado,
                ),
              ),
              SizedBox(height: 40),
              
              // Botón Cliente
              Boton(
                label: 'Soy Cliente',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInView(tipoUsuario: 'cliente'),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              
              // Botón Comercio
               Boton(
                label: 'Soy Administrador',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInView(tipoUsuario: 'administrador'), // Pasa el tipo de usuario
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              
              // Botón Administrador
               Boton(
                label: 'Soy Comercio',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInView(tipoUsuario: 'comercio'),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

              Text(
                'Selecciona el tipo de cuenta que mejor se adapte a tus necesidades',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}