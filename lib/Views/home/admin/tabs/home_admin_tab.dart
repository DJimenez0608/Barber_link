import 'package:barber_link/Routes/routes.dart'; // Importar Routes
import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/Views/Widgets/boton_con_icono.dart';

class HomeAdminTab extends StatelessWidget {
  const HomeAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView( // Envuelto en SingleChildScrollView para evitar overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente
          children: [
            Text(
              '¡Bienvenido, Administrador!',
              style: GoogleFonts.jua(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors().azulMorado,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/Images/sombrero.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 150,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/Images/bigote.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espacio ajustado
            Text(
              'Opciones de Administración',
              style: GoogleFonts.jua(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors().azulMorado,
              ),
            ),
            const SizedBox(height: 30), // Espacio ajustado
            BotonConIcono(
              onTap: () {
                Navigator.pushNamed(context, Routes.homeManagueComerce); // Usar la constante de ruta
              },
              icon: const Icon(
                Icons.store,
                color: Colors.white,
              ), 
              label: 'Gestionar Comercios', 
            ),
            const SizedBox(height: 20), 
            BotonConIcono(
              onTap: () {
                // Navegar a la pantalla de gestión de membresías
                Navigator.pushNamed(context, Routes.manageMemberships);
              },
              icon: const Icon(
                Icons.card_membership, // Ícono cambiado
                color: Colors.white,
              ), 
              label: 'Gestionar Membresías', 
            ),
            const SizedBox(height: 20), 
            BotonConIcono(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Función en desarrollo: Gestionar Usuarios')),
                );
              },
              icon: const Icon(
                Icons.group,
                color: Colors.white,
              ), 
              label: 'Gestionar Usuarios', 
            ),
            const SizedBox(height: 40), // Espacio ajustado
            Text(
              'Elije la opción que deseas administrar', // Texto ajustado
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
