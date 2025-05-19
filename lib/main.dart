// lib/main.dart
import 'package:barber_link/Routes/app_routes.dart';
import 'package:barber_link/Theme/app_colors.dart'; // Asegúrate que este import esté
import 'package:barber_link/ViewModels/admin/membership_view_model.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/ViewModels/client/client_view_model.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_comerce_viewmodel.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_viewmodel.dart';
import 'package:barber_link/ViewModels/stripe/stripe_payment_view_model.dart';
import 'package:barber_link/ViewModels/stripe/stripe_view_model.dart';
import 'package:barber_link/Views/logIn/log_in_view.dart';
import 'package:barber_link/const/stripe_key.dart';
import 'package:barber_link/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Stripe.instance.applySettings();

  try {
    await FirebaseFirestore.instance.collection('test').get();
    debugPrint('Conexión con Firestore exitosa.');
  } catch (e) {
    debugPrint('Error al conectar con Firestore: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => StripeViewModel()),
        ChangeNotifierProvider(create: (_) => HomeAdminViewModel()),
        ChangeNotifierProvider(create: (_) => HomeAdminComerceViewModel()),
        ChangeNotifierProvider(create: (_) => StripePaymentViewModel()),
        ChangeNotifierProvider(create: (_) => ClientViewModel()),
        ChangeNotifierProvider(create: (_) => MembershipViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors(); // Crear una instancia de AppColors

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'BarberLink',
      routes: appRoutes,
      theme: ThemeData(
        textTheme: GoogleFonts.juaTextTheme(
          Theme.of(context).textTheme, // Es buena práctica pasar el tema base
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: appColors.azulMorado, // Usar la instancia para acceder al color
          primary: appColors.azulMorado, // Opcional: definir el primario explícitamente
          // secondary: appColors.otroColor, // si tienes un color secundario
        ),
        useMaterial3: true,
      ),
      home: LogInView(),
    );
  }
}
