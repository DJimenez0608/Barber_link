// models/user_model.dart
class UserModel {
  final String id;
  final String? nombre;
  final String? email;
  final String? celular;
  final String? direccion;
  final String? tipoUsuario;

  UserModel({
    required this.id,
    this.nombre,
    this.email,
    this.celular,
    this.direccion,
    this.tipoUsuario,
  });

  factory UserModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return UserModel(
      id: docId,
      nombre: data['nombre'],
      email: data['email'],
      celular: data['celular'],
      direccion: data['direccion'],
      tipoUsuario: data['tipoUsuario'] ?? 'Administrador',
    );
  }
}
