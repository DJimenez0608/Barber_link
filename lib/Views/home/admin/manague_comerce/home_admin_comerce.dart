import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/fireStroe/home_admin_comerce_viewmodel.dart';
import 'package:barber_link/Views/Widgets/commerce_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeAdminComerce extends StatelessWidget {
  const HomeAdminComerce({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeAdminComerceViewModel(),
      child: _HomeAdminComerceContent(),
    );
  }
}

class _HomeAdminComerceContent extends StatefulWidget {
  const _HomeAdminComerceContent();

  @override
  State<_HomeAdminComerceContent> createState() => _HomeAdminComerceContentState();
}

class _HomeAdminComerceContentState extends State<_HomeAdminComerceContent> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeAdminComerceViewModel>(context); 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: const Text(
          'Gestionar Comercios',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Barra de búsqueda
            TextField(
              onChanged: viewModel.filterCommerces,
              decoration: InputDecoration(
                hintText: 'Buscar comercio...',
                prefixIcon: Icon(Icons.search, color: AppColors().azulMorado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de comercios
            Expanded(
              child: viewModel.filteredCommerces.isEmpty
                  ? Center(
                      child: Text(
                        'No se encontraron comercios.',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.filteredCommerces.length,
                      itemBuilder: (context, index) {
                        final commerce = viewModel.filteredCommerces[index];
                        return CommerceCard(
                          commerce: commerce,
                          onDelete: () => viewModel.deleteCommerce(commerce.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
