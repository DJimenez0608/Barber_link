import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/fireStroe/services_comerce_model.dart';
import 'package:barber_link/Views/Widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ServicesComerce extends StatelessWidget {
  final String comercioId;

  const ServicesComerce({super.key, required this.comercioId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServicesComerceModel(comercioId: comercioId),
      child: const _ServiceComerceContent(),
    );
  }
}

class _ServiceComerceContent extends StatefulWidget {
  const _ServiceComerceContent();

  @override
  State<_ServiceComerceContent> createState() => _ServiceComerceContentState();
}

class _ServiceComerceContentState extends State<_ServiceComerceContent> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ServicesComerceModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().azulMorado,
        title: const Text(
          'Comercio',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.store, color: Colors.white),
              const SizedBox(width: 16), // Espaciado entre el ícono y el borde derecho
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Barra de búsqueda
            TextField(
              onChanged: viewModel.filterServices,
              decoration: InputDecoration(
                hintText: 'Buscar servicio...',
                prefixIcon: Icon(Icons.search, color: AppColors().azulMorado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de servicios
            Expanded(
              child: viewModel.filteredServices.isEmpty
                  ? Center(
                      child: Text(
                        'No se encontraron servicios.',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = viewModel.filteredServices[index];
                        return ServiceCard(
                          service: service,
                          onEdit: () => viewModel.showEditServiceDialog(context, service),
                          onDelete: () => viewModel.deleteService(service.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().azulMorado,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => viewModel.showAddServiceDialog(context),
      ),
    );
  }
}