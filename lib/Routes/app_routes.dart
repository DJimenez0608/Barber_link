import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Views/home/home_view.dart';
import 'package:barber_link/Views/logIn/log_in_view.dart';
import 'package:barber_link/Views/new_password/new_password.dart';
import 'package:barber_link/Views/sign_in/sign_in_view.dart';
import 'package:flutter/widgets.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.logIn: (context) => const LogInView(),
    Routes.newPassword: (context) => const NewPassword(),
  };
}
