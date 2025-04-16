import 'package:barber_link/Models/serviciosComercio.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCard extends StatelessWidget {
  final ServiciosComercio service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            // Información del servicio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.nombre ?? 'Nombre no disponible',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().azulMorado,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Precio: \$${service.precio ?? '0.00'}',
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    'Duración: ${service.duracion} min',
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            // Botones de editar y eliminar
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}