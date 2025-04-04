import 'package:barber_link/Routes/routes.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            child: Text('GO HOME'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.signIn);
            },
            child: Text('GO SIGN IN'),
          ),
        ],
      ),
    );
  }
}
