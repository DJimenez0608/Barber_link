import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_viewmodel.dart';
import 'package:barber_link/Views/Widgets/info_card.dart';

class ProfileClientTab extends StatelessWidget {
  const ProfileClientTab({super.key});

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
              'Error al cargar datos del usuario',
              style: GoogleFonts.inter(fontSize: 16),
            ),
          );
        }

        final user = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,

                  decoration: BoxDecoration(
                    color: AppColors().negro,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              // Nombre del usuario
              Center(
                child: Text(
                  user.nombre ?? 'Administrador',
                  style: GoogleFonts.jua(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors().azulMorado,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Información adicional
              Text(
                'Información Personal:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 20),

              // Cuadros con información
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  InfoCard(
                    title: 'Correo',
                    icon: Icons.email,
                    value: user.email ?? 'No disponible',
                  ),
                  InfoCard(
                    title: 'Teléfono',
                    icon: Icons.phone,
                    value: user.celular ?? 'No disponible',
                  ),
                  InfoCard(
                    title: 'Dirección',
                    icon: Icons.location_on,
                    value: user.direccion ?? 'No disponible',
                  ),
                  InfoCard(
                    title: 'Tipo de Usuario',
                    icon: Icons.person,
                    value: user.tipoUsuario ?? 'Administrador',
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Historial de servicios:',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),

              Column(
                children: [
                  Container(height: 40, color: Colors.grey[300]),
                  SizedBox(height: 10),
                  Container(height: 40, color: Colors.grey[300]),
                  SizedBox(height: 10),
                  Container(height: 40, color: Colors.grey[300]),
                  SizedBox(height: 10),
                  Container(height: 40, color: Colors.grey[300]),
                  SizedBox(height: 10),
                  Container(height: 40, color: Colors.grey[300]),
                  SizedBox(height: 10),
                  Container(height: 40, color: Colors.grey[300]),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
