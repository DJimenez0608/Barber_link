import 'package:barber_link/Routes/routes.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barber-Link')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.logIn);
          },
          child: Text('LOG OUT'),
        ),
      ),
    );
  }
}
