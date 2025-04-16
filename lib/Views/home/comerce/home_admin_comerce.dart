import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/Views/Widgets/boton_con_icono.dart';

class HomeComerce extends StatelessWidget {
  const HomeComerce({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: const Text(
          'Gestionar Comercios',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Texto centrado debajo de la barra superior
            Center(
              child: Text(
                'Gestionar Comercios',
                style: GoogleFonts.jua(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors().azulMorado,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Ícono grande
            Center(
              child: Icon(
                Icons.store, // Ícono de comercio
                size: 100,
                color: AppColors().azulOscuro,
              ),
            ),
            const SizedBox(height: 75),

            // Botón "Eliminar Comercio"
            Center(
              child: BotonConIcono(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Función en desarrollo: Eliminar Comercio'),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ), // Ícono coherente
                label: 'Eliminar Comercio',
              ),
            ),
            const SizedBox(height: 75),

            // Botón "Consultar Comercios"
            Center(
              child: BotonConIcono(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Función en desarrollo: Consultar Comercios',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ), // Ícono coherente
                label: 'Consultar Comercios',
              ),
            ),
            const SizedBox(height: 75),

            // Texto centrado debajo de los botones
            Center(
              child: Text(
                'Selecciona la acción que desea realizar',
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
      ),
    );
  }
}
