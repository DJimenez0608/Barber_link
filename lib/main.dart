import 'package:barber_link/Routes/app_routes.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/Views/logIn/log_in_view.dart';
import 'package:barber_link/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Verificar conexión con Firestore
  try {
    await FirebaseFirestore.instance.collection('test').get();
    debugPrint('Conexión con Firestore exitosa.');
  } catch (e) {
    debugPrint('Error al conectar con Firestore: $e');
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      routes: appRoutes,
      theme: ThemeData(
        textTheme: GoogleFonts.juaTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: LogInView(),
    );
  }
}
