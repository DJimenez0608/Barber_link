import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/custom_alert_dialog.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    final TextEditingController nombre = TextEditingController();
    final TextEditingController direccion = TextEditingController();
    final TextEditingController celular = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
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
              await authVM.registerUser(email.text, password.text);

              final e = authVM.errorMessage;

              if (!context.mounted) {
                return;
              }
              if (e == null) {
                Navigator.pushReplacementNamed(context, Routes.home);
              } else {
                if (e == 'weak-password') {
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext context) =>
                            CustomAlertDialog(mensaje: 'Contraseña debil'),
                  );
                }
                if (e == 'email-already-in-use') {
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext context) =>
                            CustomAlertDialog(mensaje: 'Email existente'),
                  );
                }
                if (e == 'invalid-email') {
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext context) =>
                            CustomAlertDialog(mensaje: 'Email invalido'),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext context) =>
                            CustomAlertDialog(mensaje: 'Error al registrarse'),
                  );
                }
              }
            },
            label: 'Registrarme',
          ),
        ],
      ),
    );
  }
}
