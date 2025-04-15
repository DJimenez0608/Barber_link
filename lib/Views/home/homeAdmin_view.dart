import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barber_link/ViewModels/auth/home_admin_viewmodel.dart';
import 'package:barber_link/Views/home/home_admin_page.dart';
import 'package:barber_link/Views/profile/profile_admin_page.dart';


class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeAdminViewModel(),
      child: _HomeAdminViewContent(),
    );
  }
}

class _HomeAdminViewContent extends StatefulWidget {
  const _HomeAdminViewContent({super.key});

  @override
  State<_HomeAdminViewContent> createState() => _HomeAdminViewContentState();
}

class _HomeAdminViewContentState extends State<_HomeAdminViewContent> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeAdminViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: Text(
          'Panel de Administrador',
          style: TextStyle(color: AppColors().blanco),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors().azulMorado,
              ),
              child: Center(
                child: Text(
                  'Menú de Administrador',
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
                Navigator.pushReplacementNamed(context, '/log-in');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: IndexedStack(
          index: viewModel.selectedIndex,
          children: const [
            Text('Configuraciones'),
            HomeAdminHomeTab(),
            HomeAdminProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors().azulMorado,
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.setSelectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Casa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: AppColors().blanco,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}