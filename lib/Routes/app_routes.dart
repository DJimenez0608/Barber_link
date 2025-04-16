import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Views/home/client/home_client_view.dart';
import 'package:barber_link/Views/logIn/log_in_view.dart';
import 'package:barber_link/Views/password/new_password_view.dart';
import 'package:barber_link/Views/sign_in/sign_in_view.dart';
import 'package:flutter/widgets.dart';
import 'package:barber_link/Views/home/admin/home_admin_view.dart';
import 'package:barber_link/Views/home/admin/manague_comerce/home_admin_comerce.dart';
import 'package:barber_link/Views/home/comerce/home_comerce_view.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeClientView(),
    //Routes.homeClient: (context) => const HomeClientView(),
    Routes.homeComerce: (context) => const HomeComerceView(),
    Routes.homeAdmin: (context) => const HomeAdminView(),
    Routes.homeManagueComerce: (context) => HomeAdminComerce(),
    Routes.signIn: (context) => const SignInView(tipoUsuario: 'administrador'),
    Routes.logIn: (context) => const LogInView(),
    Routes.newPassword: (context) => const NewPasswordView(),
  };
}
