// lib/Models/usuario.dart
class UserModel {
  final String id;
  final String? nombre;
  final String? email;
  final String? celular;
  final String? direccion;
  final String? tipoUsuario;
  // final String? imageUrl; // Eliminado

  UserModel({
    required this.id,
    this.nombre,
    this.email,
    this.celular,
    this.direccion,
    this.tipoUsuario,
    // this.imageUrl, // Eliminado
  });

  factory UserModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return UserModel(
      id: docId,
      nombre: data['nombre'] as String?,
      email: data['email'] as String?,
      celular: data['celular'] as String?,
      direccion: data['direccion'] as String?,
      tipoUsuario: data['tipoUsuario'] as String? ?? 'cliente',
      // imageUrl: data['imageUrl'] as String?, // Eliminado
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) 'nombre': nombre,
      if (email != null) 'email': email,
      if (celular != null) 'celular': celular,
      if (direccion != null) 'direccion': direccion,
      if (tipoUsuario != null) 'tipoUsuario': tipoUsuario,
      // if (imageUrl != null) 'imageUrl': imageUrl, // Eliminado
    };
  }
}
