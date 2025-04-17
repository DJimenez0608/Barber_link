import 'package:barber_link/Models/usuario.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommerceCard extends StatelessWidget {
  final UserModel commerce;
  final VoidCallback onDelete;

  const CommerceCard({
    super.key,
    required this.commerce,
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
            // Espacio para la imagen
            Container(
              height: 80,
              width: 80,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 15),

            // Información del comercio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commerce.nombre ?? 'Sin nombre',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().azulMorado,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        commerce.direccion ?? 'Sin dirección',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        commerce.email ?? 'Sin correo',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        commerce.celular ?? 'Sin teléfono',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Botón de eliminar
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