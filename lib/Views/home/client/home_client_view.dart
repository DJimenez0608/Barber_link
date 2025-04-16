import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/auth/auth_view_model.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:barber_link/Views/home/client/tabs/configuration_client_tab.dart';
import 'package:barber_link/Views/home/client/tabs/home_client_tab.dart';
import 'package:barber_link/Views/home/client/tabs/profile_client_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeClientView extends StatefulWidget {
  const HomeClientView({super.key});

  @override
  State<HomeClientView> createState() => _HomeClientViewState();
}

class _HomeClientViewState extends State<HomeClientView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ConfigurationClientTab(),
    HomeClientTab(),
    ProfileClientTab(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Boton(
                onTap: () async {
                  final viewModel = context.read<AuthViewModel>();
                  await viewModel.logOut();
                  if (viewModel.errorMessage == null) {
                    Navigator.pushReplacementNamed(context, Routes.logIn);
                  } else {
                    SnackBar(content: Text('Error al finalizar sesion'));
                  }
                },
                label: 'LOG OUT',
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'BarberLink',
          style: TextStyle(color: AppColors().blanco, fontSize: 35),
        ),
        backgroundColor: AppColors().azulMorado,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors().azulMorado,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Casa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: AppColors().blanco,
      ),
    );
  }
}
