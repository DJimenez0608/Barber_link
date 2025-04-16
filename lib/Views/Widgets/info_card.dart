import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Fondo gris claro
        borderRadius: BorderRadius.circular(8), // Bordes redondeados
      ),
      padding: const EdgeInsets.all(15), // Espaciado interno
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors().azulMorado,
              ), // Ícono con color principal
              const SizedBox(width: 8), // Espaciado entre ícono y texto
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 17, // Tamaño reducido para el título
                    fontWeight: FontWeight.bold,

                    color: Colors.grey[800], // Color del texto del título
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Espaciado entre título y valor
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15, // Tamaño reducido para el valor
              color: Colors.grey[700], // Color del texto del valor
            ),
            overflow:
                TextOverflow.ellipsis, // Muestra "..." si el texto es muy largo
            maxLines: 2, // Limita el texto a 2 líneas
            softWrap: true, // Permite que el texto se ajuste automáticamente
          ),
        ],
      ),
    );
  }
}
