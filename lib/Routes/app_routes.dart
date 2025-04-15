import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Views/home/home_view.dart';
import 'package:barber_link/Views/logIn/log_in_view.dart';
import 'package:barber_link/Views/new_password/new_password.dart';
import 'package:barber_link/Views/sign_in/sign_in_view.dart';
import 'package:flutter/widgets.dart';
import 'package:barber_link/Views/home/homeAdmin_view.dart'; // Import the missing class

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeView(),
    //Routes.homeClient: (context) => const HomeClientView(),
    //Routes.homeComerce: (context) => const HomeComerceView(),
    Routes.homeAdmin: (context) => const HomeAdminView(),
    Routes.signIn: (context) => const SignInView(tipoUsuario: 'administrador'),
    Routes.logIn: (context) => const LogInView(),
    Routes.newPassword: (context) => const NewPassword(),
  };
}
