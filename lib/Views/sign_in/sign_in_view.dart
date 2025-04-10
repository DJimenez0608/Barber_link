import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nombre = TextEditingController();
    final TextEditingController _direccion = TextEditingController();
    final TextEditingController _celular = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: Text(
          'Resgistro de nuevo usuario',
          style: TextStyle(color: AppColors().blanco),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CustomFormField(controller: _nombre, label: 'Nombre'),
          SizedBox(height: 20),
          CustomFormField(controller: _direccion, label: 'Dirección'),
          SizedBox(height: 20),
          CustomFormField(controller: _celular, label: 'Número celular'),
          SizedBox(height: 20),
          CustomFormField(controller: _email, label: 'Correo electronico'),
          SizedBox(height: 20),
          CustomFormField(controller: _password, label: 'Contraseña'),
          SizedBox(height: 40),
          Boton(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            label: 'Registrarme',
          ),
        ],
      ),
    );
  }
}
