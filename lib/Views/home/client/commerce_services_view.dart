// import 'package:barber_link/Models/serviciosComercio.dart'; // Efectivamente no usado directamente aquí
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/client/client_view_model.dart';
import 'package:barber_link/Views/Widgets/pagar_servicio.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommerceServicesView extends StatefulWidget {
  const CommerceServicesView({super.key});

  @override
  State<CommerceServicesView> createState() => _CommerceServicesViewState();
}

class _CommerceServicesViewState extends State<CommerceServicesView> {
  final TextEditingController _searchServiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchServiceController.addListener(() {
      Provider.of<ClientViewModel>(context, listen: false)
          .filterServices(_searchServiceController.text);
    });
  }

  @override
  void dispose() {
    _searchServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);
    final commerce = clientViewModel.selectedCommerce; 

    if (commerce == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error", style: TextStyle(color: AppColors().blanco)),
          backgroundColor: AppColors().azulMorado,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors().blanco),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: Text("No se ha seleccionado ningún comercio.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          commerce.nombre ?? 'Servicios del Comercio',
          style: TextStyle(color: AppColors().blanco, fontSize: 22),
        ),
        backgroundColor: AppColors().azulMorado,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors().blanco),
          onPressed: () {
            clientViewModel.clearSelectedCommerceAndServices(); 
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchServiceController,
              decoration: InputDecoration(
                hintText: 'Buscar servicio...',
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
              'Servicios Ofrecidos:',
              style: GoogleFonts.jua(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors().negro,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: clientViewModel.isLoadingServices
                  ? const Center(child: CircularProgressIndicator())
                  : clientViewModel.errorMessage != null && clientViewModel.filteredServicesForSelectedCommerce.isEmpty
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
                      : clientViewModel.filteredServicesForSelectedCommerce.isEmpty
                          ? Center(
                              child: Text(
                                _searchServiceController.text.isEmpty
                                ? 'Este comercio aún no tiene servicios registrados.'
                                : 'No se encontraron servicios para "${_searchServiceController.text}".',
                                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: clientViewModel.filteredServicesForSelectedCommerce.length,
                              itemBuilder: (context, index) {
                                final service = clientViewModel.filteredServicesForSelectedCommerce[index];
                                
                                // Corrección para el precio:
                                // Aseguramos que service.precio sea tratado como String antes de usar replaceAll.
                                // Y luego parseamos a int.
                                final String precioComoString = service.precio ?? "0";
                                final int valorDelServicio = int.tryParse(
                                  precioComoString.replaceAll(RegExp(r'[^0-9]'), '') 
                                ) ?? 0;

                                return PagarServicio( 
                                  value: valorDelServicio,
                                  label: service.nombre ?? 'Servicio sin nombre',
                                  // Usamos una imagen placeholder ya que imagenUrl fue descartado
                                  image: 'assets/Images/clasico.png', // Placeholder
                                  // Se podría añadir un campo para la duración en PagarServicio si se desea
                                  // duracion: service.duracion,
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
