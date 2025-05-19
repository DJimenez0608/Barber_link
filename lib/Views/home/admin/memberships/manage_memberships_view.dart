// lib/Views/home/admin/memberships/manage_memberships_view.dart
import 'package:barber_link/Models/membership_model.dart';
import 'package:barber_link/Routes/routes.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/admin/membership_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Para formatear el precio
import 'package:provider/provider.dart';

class ManageMembershipsView extends StatelessWidget {
  const ManageMembershipsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usar un Consumer para escuchar cambios y reconstruir solo lo necesario
    return Consumer<MembershipViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Gestionar Membresías', style: TextStyle(color: AppColors().blanco)),
            backgroundColor: AppColors().azulMorado,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors().blanco),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: _buildBody(context, viewModel),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.addEditMembership,
                arguments: null, // No se pasa membresía para crear una nueva
              );
            },
            backgroundColor: AppColors().azulMorado,
            tooltip: 'Agregar Membresía',
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MembershipViewModel viewModel) {
    if (viewModel.isLoading && viewModel.memberships.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null && viewModel.memberships.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            viewModel.errorMessage!,
            style: TextStyle(color: Colors.red[700], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (viewModel.memberships.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No hay membresías creadas aún. Presiona el botón "+" para agregar una nueva.',
            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Formateador de moneda
    final currencyFormatter = NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0);

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: viewModel.memberships.length,
      itemBuilder: (context, index) {
        final membership = viewModel.memberships[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            title: Text(
              membership.nombrePlan,
              style: GoogleFonts.jua(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors().azulMorado),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  membership.descripcion,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                Text(
                  "Precio: ${currencyFormatter.format(membership.precio)}",
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Duración: ${membership.duracion}",
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue[600]),
                  tooltip: 'Editar',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.addEditMembership,
                      arguments: membership, // Pasar la membresía para editarla
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red[600]),
                  tooltip: 'Eliminar',
                  onPressed: () => _confirmDelete(context, viewModel, membership),
                ),
              ],
            ),
            onTap: () {
               Navigator.pushNamed(
                context,
                Routes.addEditMembership,
                arguments: membership, // También navega a editar al tocar el tile
              );
            },
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, MembershipViewModel viewModel, MembershipModel membership) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar la membresía "${membership.nombrePlan}"? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Cerrar diálogo de confirmación
                if (membership.id != null) {
                  final success = await viewModel.deleteMembership(membership.id!);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Membresía "${membership.nombrePlan}" eliminada.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (context.mounted && viewModel.errorMessage != null) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al eliminar: ${viewModel.errorMessage}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
