import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/Widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfigurationComerceTab extends StatefulWidget {
  const ConfigurationComerceTab({super.key});

  @override
  State<ConfigurationComerceTab> createState() => _ConfigurationComerceTabState();
}

class _ConfigurationComerceTabState extends State<ConfigurationComerceTab> {
  //PROVIDERS

  //TEXT EDITTING
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seguridad:',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Boton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustomFormField(
                            controller: newPassword,
                            label: 'Nueva contraseña',
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: confirmPassword,
                            label: 'Confirmar Contraseña',
                          ),
                          SizedBox(height: 20),
                          Boton(
                            onTap: () {
                              final viewModel = context.read<AuthViewModel>();
                              if (newPassword.text == confirmPassword.text) {
                                setState(() {
                                  txt = '';
                                });
                                viewModel.changePassword(newPassword.text);
                                if (viewModel.errorMessage == null) {
                                  Navigator.pop(context);
                                }
                              } else {
                                setState(() {
                                  txt = 'las contraseñas no coinciden';
                                });
                              }
                            },
                            label: 'Cambiar contraseña',
                          ),
                          Text(txt),
                        ],
                      ),
                    );
                  },
                );
              },
              label: 'Cambiar contraseña',
            ),
            SizedBox(height: 2),
            Boton(onTap: () {}, label: 'Eliminar cuenta '),
          ],
        ),
      ),
    );
  }
}
