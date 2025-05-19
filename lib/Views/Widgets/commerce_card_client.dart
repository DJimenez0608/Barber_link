import 'package:barber_link/Models/usuario.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommerceCardClient extends StatelessWidget {
  final UserModel commerce;
  final VoidCallback onTap;

  const CommerceCardClient({
    super.key,
    required this.commerce,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icono o Imagen del Comercio (Placeholder por ahora)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors().azulMorado.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.store, // Icono genérico de tienda
                  color: AppColors().azulMorado,
                  size: 30,
                ),
                // Si tuvieras commerce.imageUrl, podrías usar:
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: Image.network(
                //     commerce.imageUrl!,
                //     width: 60,
                //     height: 60,
                //     fit: BoxFit.cover,
                //     errorBuilder: (context, error, stackTrace) => Icon(Icons.store, color: AppColors().azulMorado, size: 30),
                //     loadingBuilder: (context, child, loadingProgress) {
                //       if (loadingProgress == null) return child;
                //       return Center(child: CircularProgressIndicator(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                //             : null,
                //       ));
                //     },
                //   ),
                // ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commerce.nombre ?? 'Comercio Sin Nombre',
                      style: GoogleFonts.jua( // Usando la fuente global
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors().negro,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      commerce.direccion ?? 'Dirección no disponible',
                      style: GoogleFonts.inter( // Fuente Inter para detalles
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
