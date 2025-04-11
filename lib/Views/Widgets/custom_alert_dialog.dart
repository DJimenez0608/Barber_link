import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.mensaje});
  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(mensaje),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ok'),
        ),
      ],
    );
  }
}
