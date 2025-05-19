    // lib/Routes/app_routes.dart
    import 'package:barber_link/Models/membership_model.dart'; // Necesario para el argumento
    import 'package:barber_link/Views/home/admin/memberships/add_edit_membership_view.dart'; // Importar vista
    import 'package:barber_link/Views/home/admin/memberships/manage_memberships_view.dart'; // Importar vista
    import 'package:barber_link/Views/home/client/commerce_services_view.dart';
    import 'package:barber_link/Views/home/client/home_client_view.dart';
    import 'package:barber_link/Views/home/comerce/home_comerce_view.dart';
    import 'package:barber_link/Views/home/admin/home_admin_view.dart';
    import 'package:barber_link/Views/home/admin/manague_comerce/home_admin_comerce.dart';
    import 'package:barber_link/Views/logIn/log_in_view.dart';
    import 'package:barber_link/Views/logIn/log_in_comercio_view.dart';
    import 'package:barber_link/Views/password/new_password_view.dart';
    import 'package:barber_link/Views/sign_in/sign_in_view.dart';
    import 'package:flutter/widgets.dart';
    import 'package:barber_link/Routes/routes.dart'; 

    Map<String, Widget Function(BuildContext)> get appRoutes {
      return {
        Routes.home: (context) => const HomeClientView(),
        Routes.homeComerce: (context) => const HomeComerceView(),
        Routes.homeAdmin: (context) => const HomeAdminView(),
        Routes.homeManagueComerce: (context) => const HomeAdminComerce(),
        Routes.signIn: (context) => const SignInView(tipoUsuario: 'cliente'),
        Routes.logIn: (context) => const LogInView(),
        Routes.logInComercio: (context) => const LogInComercioView(),
        Routes.newPassword: (context) => const NewPasswordView(),
        Routes.commerceServices: (context) => const CommerceServicesView(),
        
        // Rutas para membresías
        Routes.manageMemberships: (context) => const ManageMembershipsView(),
        Routes.addEditMembership: (context) {
          final membership = ModalRoute.of(context)?.settings.arguments as MembershipModel?; // Puede ser nulo
          return AddEditMembershipView(membership: membership);
        },
      };
    }
    