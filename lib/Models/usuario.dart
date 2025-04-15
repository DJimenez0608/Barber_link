// models/user_model.dart
class UserModel {
  final String? nombre;
  final String? email;
  final String? celular;
  final String? direccion;
  final String? tipoUsuario;

  UserModel({
    this.nombre,
    this.email,
    this.celular,
    this.direccion,
    this.tipoUsuario,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      nombre: data['nombre'],
      email: data['email'],
      celular: data['celular'],
      direccion: data['direccion'],
      tipoUsuario: data['tipoUsuario'] ?? 'Administrador',
    );
  }
}
