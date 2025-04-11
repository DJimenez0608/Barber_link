import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: Text(
          'Restaurar contraseña',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CustomFormField(
            controller: emailController,
            label: 'Email registrado',
          ),
          SizedBox(height: 20),
          CustomFormField(
            controller: emailController,
            label: 'Nueva Contraseña',
          ),
          SizedBox(height: 20),
          CustomFormField(
            controller: emailController,
            label: 'Confirmacion nueva contraseña',
          ),
          SizedBox(height: 30),
          Boton(onTap: () {}, label: 'Cambiar'),
        ],
      ),
    );
  }
}
