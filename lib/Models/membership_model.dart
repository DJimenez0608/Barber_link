// lib/Models/membership_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class MembershipBenefit {
  String nombreServicio;
  int cantidad;

  MembershipBenefit({
    required this.nombreServicio,
    required this.cantidad,
  });

  // Método para convertir un objeto MembershipBenefit a un Map
  Map<String, dynamic> toMap() {
    return {
      'nombreServicio': nombreServicio,
      'cantidad': cantidad,
    };
  }

  // Método factory para crear un objeto MembershipBenefit desde un Map
  factory MembershipBenefit.fromMap(Map<String, dynamic> map) {
    return MembershipBenefit(
      nombreServicio: map['nombreServicio'] as String? ?? '',
      cantidad: map['cantidad'] as int? ?? 0,
    );
  }
}

class MembershipModel {
  final String? id; // Puede ser nulo si es una nueva membresía aún no guardada
  final String nombrePlan;
  final String descripcion;
  final double precio;
  final String duracion; // Ej: "Mensual", "Anual", "30 días"
  final List<MembershipBenefit> beneficios;
  final String condiciones;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  MembershipModel({
    this.id,
    required this.nombrePlan,
    required this.descripcion,
    required this.precio,
    required this.duracion,
    required this.beneficios,
    required this.condiciones,
    this.createdAt,
    this.updatedAt,
  });

  // Método para convertir un objeto MembershipModel a un Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nombrePlan': nombrePlan,
      'descripcion': descripcion,
      'precio': precio,
      'duracion': duracion,
      'beneficios': beneficios.map((b) => b.toMap()).toList(), // Convertir lista de objetos a lista de Maps
      'condiciones': condiciones,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(), // Poner timestamp al crear
      'updatedAt': FieldValue.serverTimestamp(), // Siempre actualizar timestamp
    };
  }

  // Método factory para crear un objeto MembershipModel desde un DocumentSnapshot de Firestore
  factory MembershipModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Documento de membresía no encontrado o datos corruptos.");
    }

    // Convertir la lista de Maps de beneficios a una lista de objetos MembershipBenefit
    final List<dynamic> beneficiosData = data['beneficios'] as List<dynamic>? ?? [];
    final List<MembershipBenefit> beneficiosList = beneficiosData
        .map((item) => MembershipBenefit.fromMap(item as Map<String, dynamic>))
        .toList();

    return MembershipModel(
      id: snapshot.id,
      nombrePlan: data['nombrePlan'] as String? ?? '',
      descripcion: data['descripcion'] as String? ?? '',
      precio: (data['precio'] as num?)?.toDouble() ?? 0.0,
      duracion: data['duracion'] as String? ?? '',
      beneficios: beneficiosList,
      condiciones: data['condiciones'] as String? ?? '',
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }

  // Método para crear una copia del modelo con algunos campos actualizados (útil para edición)
  MembershipModel copyWith({
    String? id,
    String? nombrePlan,
    String? descripcion,
    double? precio,
    String? duracion,
    List<MembershipBenefit>? beneficios,
    String? condiciones,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return MembershipModel(
      id: id ?? this.id,
      nombrePlan: nombrePlan ?? this.nombrePlan,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      duracion: duracion ?? this.duracion,
      beneficios: beneficios ?? this.beneficios,
      condiciones: condiciones ?? this.condiciones,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
