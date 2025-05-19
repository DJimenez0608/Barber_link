import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/client/client_view_model.dart';
import 'package:barber_link/Views/Widgets/commerce_card_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:barber_link/Routes/routes.dart'; // Asegúrate que este import esté presente y sea correcto

class HomeClientTab extends StatefulWidget {
  const HomeClientTab({super.key});

  @override
  State<HomeClientTab> createState() => _HomeClientTabState();
}

class _HomeClientTabState extends State<HomeClientTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      Provider.of<ClientViewModel>(context, listen: false).filterCommerces(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar barbería o comercio...',
              prefixIcon: Icon(Icons.search, color: AppColors().azulMorado),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Barberías y Comercios Disponibles:',
            style: GoogleFonts.jua(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors().negro,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: clientViewModel.isLoadingCommerces
                ? const Center(child: CircularProgressIndicator())
                : clientViewModel.errorMessage != null && clientViewModel.filteredCommerces.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            clientViewModel.errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : clientViewModel.filteredCommerces.isEmpty
                        ? Center(
                            child: Text(
                              _searchController.text.isEmpty
                                ? 'No hay comercios disponibles.'
                                : 'No se encontraron comercios para "${_searchController.text}".',
                              style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemCount: clientViewModel.filteredCommerces.length,
                            itemBuilder: (context, index) {
                              final commerce = clientViewModel.filteredCommerces[index];
                              return CommerceCardClient(
                                commerce: commerce,
                                onTap: () {
                                  clientViewModel.selectCommerce(commerce);
                                  Navigator.pushNamed(
                                    context,
                                    Routes.commerceServices, // Uso de la constante
                                  );
                                },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
