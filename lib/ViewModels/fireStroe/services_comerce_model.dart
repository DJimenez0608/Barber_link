import 'package:barber_link/Models/serviciosComercio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barber_link/Theme/app_colors.dart';

class ServicesComerceModel extends ChangeNotifier {
  final List<ServiciosComercio> _services = [];
  List<ServiciosComercio> filteredServices = [];

  ServicesComerceModel() {
    fetchServices();
  }

  // Obtener servicios desde Firestore
  Future<void> fetchServices() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .get();

      _services.clear();
      for (var doc in querySnapshot.docs) {
        _services.add(ServiciosComercio.fromFirestore(doc.id, doc.data()));
      }
      filteredServices = List.from(_services);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al obtener servicios: $e');
    }
  }

  // Filtrar servicios por nombre
  void filterServices(String query) {
    if (query.isEmpty) {
      filteredServices = List.from(_services);
    } else {
      filteredServices = _services
          .where((service) =>
              service.nombre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Eliminar servicio
  Future<void> deleteService(String serviceId) async {
    try {
      await FirebaseFirestore.instance.collection('services').doc(serviceId).delete();
      _services.removeWhere((service) => service.id == serviceId);
      filteredServices.removeWhere((service) => service.id == serviceId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar servicio: $e');
    }
  }

  // Mostrar diálogo para agregar servicio
  void showAddServiceDialog(BuildContext context) {
    _showServiceDialog(
      context,
      'Agregar Servicio',
      (nombre, precio, duracion) async {
        await FirebaseFirestore.instance.collection('services').add({
          'nombre': nombre,
          'precio': precio,
          'duracion': duracion,
        });
        fetchServices();
      },
    );
  }

  // Mostrar diálogo para editar servicio
  void showEditServiceDialog(BuildContext context, ServiciosComercio service) {
    _showServiceDialog(
      context,
      'Modificar Servicio',
      (nombre, precio, duracion) async {
        await FirebaseFirestore.instance.collection('services').doc(service.id).update({
          'nombre': nombre,
          'precio': precio,
          'duracion': duracion,
        });
        fetchServices();
      },
      service: service,
    );
  }

  // Diálogo genérico para agregar o editar servicio
  void _showServiceDialog(
    BuildContext context,
    String title,
    Future<void> Function(String nombre, String precio, String duracion) onSubmit, {
    ServiciosComercio? service,
  }) {
    final nombreController = TextEditingController(text: service?.nombre ?? '');
    final precioController = TextEditingController(text: service?.precio ?? '');
    final duracionController = TextEditingController(text: service?.duracion ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors().azulMorado,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de texto para el nombre
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),

            // Campo de texto para el precio
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),

            // Campo de texto para la duración
            TextField(
              controller: duracionController,
              decoration: const InputDecoration(
                labelText: 'Duración (minutos)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              final nombre = nombreController.text.trim();
              final precio = precioController.text.trim();
              final duracion = duracionController.text.trim();

              await onSubmit(nombre, precio, duracion);
              Navigator.pop(context);
            },
            child: const Text('Aplicar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}