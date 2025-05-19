// lib/Models/serviciosComercio.dart
class ServiciosComercio {
  final String id;
  final String? nombre;
  final String? precio; // Se mantiene como String? para consistencia con Firestore
  final String? duracion; // Se mantiene como String?
  final String? comercioId;
  // final String? imagenUrl; // Eliminado

  ServiciosComercio({
    required this.id,
    this.nombre,
    this.precio,
    this.duracion,
    this.comercioId,
    // this.imagenUrl, // Eliminado
  });

  factory ServiciosComercio.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return ServiciosComercio(
      id: docId,
      nombre: data['nombre'] as String?,
      precio: data['precio']?.toString(), // Asegura que sea String
      duracion: data['duracion']?.toString(), // Asegura que sea String
      comercioId: data['comercioId'] as String?,
      // imagenUrl: data['imagenUrl'] as String?, // Eliminado
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) 'nombre': nombre,
      if (precio != null) 'precio': precio,
      if (duracion != null) 'duracion': duracion,
      if (comercioId != null) 'comercioId': comercioId,
      // if (imagenUrl != null) 'imagenUrl': imagenUrl, // Eliminado
    };
  }
}
