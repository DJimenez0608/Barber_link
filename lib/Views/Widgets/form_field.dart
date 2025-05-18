import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final bool enable;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    this.label,
    this.obscureText = false,
    required this.controller,
    this.enable = true,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: TextFormField(
        obscureText: _obscureText,
        enabled: widget.enable,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors().azulMorado),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(color: AppColors().negro),
          border: OutlineInputBorder(),
          suffixIcon:
              widget.obscureText
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                  : null,
        ),
        controller: widget.controller,
      ),
    );
  }
}
