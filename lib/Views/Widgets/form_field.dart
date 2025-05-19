import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final bool enable;
  final TextEditingController controller;
  // final String? Function(String?)? validator; // Eliminado

  const CustomFormField({
    super.key,
    this.label,
    this.obscureText = true, // Default a true como en el original
    required this.controller,
    this.enable = true,
    // this.validator, // Eliminado
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureTextState; // Renombrado para evitar confusión con widget.obscureText

  @override
  void initState() {
    super.initState();
    _obscureTextState = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: TextFormField(
        obscureText: _obscureTextState,
        enabled: widget.enable,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors().azulMorado),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(color: AppColors().negro),
          border: OutlineInputBorder(),
          suffixIcon:
              widget.obscureText // Usar widget.obscureText para decidir si mostrar el icono
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureTextState = !_obscureTextState;
                      });
                    },
                    icon: Icon(
                      _obscureTextState ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                  : null,
        ),
        controller: widget.controller,
        // validator: widget.validator, // Eliminado
      ),
    );
  }
}
