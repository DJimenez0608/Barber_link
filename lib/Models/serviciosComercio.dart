class ServiciosComercio {
  final String id;
  final String? nombre;
  final String? precio;
  final String? duracion;
  final String? comercioId; // Nuevo atributo para relacionar el servicio con un comercio

  ServiciosComercio({
    required this.id,
    this.nombre,
    this.precio,
    this.duracion,
    this.comercioId,
  });

  factory ServiciosComercio.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return ServiciosComercio(
      id: docId,
      nombre: data['nombre'],
      precio: data['precio']?.toString(),
      duracion: data['duracion'],
      comercioId: data['comercioId'], // Asignar el comercioId desde Firestore
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'precio': precio,
      'duracion': duracion,
      'comercioId': comercioId, // Incluir comercioId al guardar en Firestore
    };
  }
}
