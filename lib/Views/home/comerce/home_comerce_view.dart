import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/home/comerce/tabs/configuration_comerce_tab.dart';
import 'package:barber_link/Views/home/comerce/tabs/home_comerce_tab.dart';
import 'package:barber_link/Views/home/comerce/tabs/profile_comerce_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_viewmodel.dart';

class HomeComerceView extends StatefulWidget {
  const HomeComerceView({super.key});

  @override
  State<HomeComerceView> createState() => _HomeComerceViewState();
}

class _HomeComerceViewState extends State<HomeComerceView> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    ConfigurationComerceTab(),
    HomeComerceTab(),
    ProfileComerceTab(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeAdminViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: Text(
          'Panel de Comercio',
          style: TextStyle(color: AppColors().blanco),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors().azulMorado),
              child: Center(
                child: Text(
                  'Menú de Comercio',
                  style: GoogleFonts.jua(
                    fontSize: 20,
                    color: AppColors().blanco,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: AppColors().azulMorado),
              title: Text(
                'Cerrar Sesión',
                style: GoogleFonts.inter(fontSize: 16),
              ),
              onTap: () async {
                await viewModel.signOut();
                Navigator.pushReplacementNamed(context, Routes.logIn);
              },
            ),
          ],
        ),
      ),
      body: Center( child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors().azulMorado,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Casa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: AppColors().blanco,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}