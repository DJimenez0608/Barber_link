import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton_con_icono.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/Views/home/comerce/services_comerce/services_comerce.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_viewmodel.dart';

class HomeComerceTab extends StatelessWidget {
  const HomeComerceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeAdminViewModel();

    return FutureBuilder(
      future: viewModel.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Error al cargar datos del comercio',
              style: GoogleFonts.inter(fontSize:16),
            ),
          );
        }

        final user = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texto de bienvenida
              Center(
                child: Text(
                  '¡Bienvenido Comerciante!',
                  style: GoogleFonts.jua(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors().azulMorado,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Icono de tienda con el bigote encima
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/Images/bigote.png', // Bigote
                      height: 100,
                      width: 100,
                    ),
                    const Icon(
                      Icons.store, // Icono de tienda
                      size: 100,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Botón de servicios
              Center(
                child: BotonConIcono(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesComerce(comercioId: user.id), // Pasar comercioId
                      ),
                    );
                  },
                  icon: const Icon(Icons.design_services, color: Colors.white), // Ícono de servicios
                  label: 'Servicios',
                ),
              ),
              const SizedBox(height: 50),

              // Texto debajo de los botones
              Center(
                child: Text(
                  'Elije la acción que deseas realizar hoy',
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
      },
    );
  }
}