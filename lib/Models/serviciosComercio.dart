class ServiciosComercio {
  final String id;
  final String? nombre;
  final String? precio;
  final String? duracion;

  ServiciosComercio({
    required this.id,
    this.nombre,
    this.precio,
    this.duracion,
  });

  factory ServiciosComercio.fromFirestore(String docId, Map<String, dynamic> data) {
    return ServiciosComercio(
      id: docId,
      nombre: data['nombre'],
      precio: data['precio'],
      duracion: data['duracion'],
    );
  }
}