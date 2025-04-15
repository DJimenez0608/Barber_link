import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/custom_alert_dialog.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  final String tipoUsuario; // Nuevo parámetro para el tipo de usuario

  const SignInView({super.key, required this.tipoUsuario});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController nombre = TextEditingController();
  final TextEditingController direccion = TextEditingController();
  final TextEditingController celular = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  
  @override
  void dispose() {
    nombre.dispose();
    direccion.dispose();
    celular.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
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
          CustomFormField(controller: nombre, label: 'Nombre'),
          SizedBox(height: 20),
          CustomFormField(controller: direccion, label: 'Dirección'),
          SizedBox(height: 20),
          CustomFormField(controller: celular, label: 'Número celular'),
          SizedBox(height: 20),
          CustomFormField(controller: email, label: 'Correo electronico'),
          SizedBox(height: 20),
          CustomFormField(controller: password, label: 'Contraseña'),
          SizedBox(height: 40),
          Boton(
            onTap: () async {
              // Define el tipo de usuario como el proporcionado en el widget
              final tipoUsuario = widget.tipoUsuario;

              await authVM.registerUser(
                email.text,
                password.text,
                nombre.text,
                direccion.text,
                celular.text,
                tipoUsuario,
              );

              final e = authVM.errorMessage;

              if (!context.mounted) {
                return;
              }
              if (e == null) {
                Navigator.pushReplacementNamed(context, Routes.home);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CustomAlertDialog(mensaje: e),
                );
              }
            },
            label: 'Registrarme',
          ),
        ],
      ),
    );
  }
}
