import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String? label;
  final bool enable;
  final TextEditingController controller;
  const CustomFormField({
    super.key,
    this.label,
    required this.controller,
    this.enable = true,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: TextFormField(
        enabled: widget.enable,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors().azulMorado),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(color: AppColors().negro),
          border: OutlineInputBorder(),
        ),
        controller: widget.controller,
      ),
    );
  }
}
