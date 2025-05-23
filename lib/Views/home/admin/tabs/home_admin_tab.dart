import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/home/admin/manague_comerce/home_admin_comerce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/Views/Widgets/boton_con_icono.dart';

class HomeAdminTab extends StatelessWidget {
  const HomeAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de bienvenida
          Center(
            child: Text(
              '¡Bienvenido, Administrador!',
              style: GoogleFonts.jua(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors().azulMorado,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Imagen del bigote
          Center(
            child: Stack(
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
          ),

          // Texto de opciones de administración
          Center(
            child: Text(
              'Opciones de Administración',
              style: GoogleFonts.jua(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors().azulMorado,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Botón para gestionar comercios
          Center(
            child: BotonConIcono(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeAdminComerce(),
                  ),
                );
              },
              icon: const Icon(
                Icons.store,
                color: Colors.white,
              ), // Ícono del botón
              label: 'Gestionar Comercios', // Texto del botón
            ),
          ),
          const SizedBox(height: 50), // Separación de 50px
          // Botón para gestionar membresías
          Center(
            child: BotonConIcono(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Función en desarrollo')),
                );
              },
              icon: const Icon(
                Icons.attach_money,
                color: Colors.white,
              ), // Ícono del botón
              label: 'Gestionar Membresías', // Texto del botón
            ),
          ),
          const SizedBox(height: 50), // Separación de 50px
          // Botón para gestionar usuarios
          Center(
            child: BotonConIcono(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Función en desarrollo')),
                );
              },
              icon: const Icon(
                Icons.group,
                color: Colors.white,
              ), // Ícono del botón
              label: 'Gestionar Usuarios', // Texto del botón
            ),
          ),
          const SizedBox(height: 50), // Separación de 50px
          // Texto debajo de los botones
          Center(
            child: Text(
              'Elije la opción que deseas monitorear',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
