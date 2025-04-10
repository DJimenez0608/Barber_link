import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  const Boton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(150, 40),
        backgroundColor: AppColors().azulMorado,
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(color: AppColors().blanco, fontSize: 17),
      ),
    );
  }
}
