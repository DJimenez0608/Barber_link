import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/Views/Widgets/boton.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Configuraciones'),
    Text('Casa'),
    Text('Perfil'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Boton(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.logIn);
          },
          label: 'LOG OUT',
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
      floatingActionButton: FloatingActionButton(onPressed: () {}),
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
