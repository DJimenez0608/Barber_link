import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class BotonConIcono extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final Icon icon;

  const BotonConIcono({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50), // Tamaño mínimo del botón
        backgroundColor: AppColors().azulMorado, // Color de fondo
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      ),
      onPressed: onTap,
      icon: icon, // Ícono del botón
      label: Text(
        label,
        style: TextStyle(
          color: AppColors().blanco, // Color del texto
          fontSize: 16, // Tamaño de fuente
          fontWeight: FontWeight.bold, // Peso de la fuente
        ),
      ),
    );
  }
}
