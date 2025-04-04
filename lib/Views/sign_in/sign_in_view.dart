import 'package:barber_link/Routes/routes.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.home);
        },
        child: Text('GO HOME'),
      ),
    );
  }
}
