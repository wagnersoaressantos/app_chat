import 'package:cloud_firestore/cloud_firestore.dart';

class GrupoModel {
  final String id;
  final String nome;

  GrupoModel({required this.id, required this.nome});

  factory GrupoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GrupoModel(
      id: doc.id,
      nome: data['nome'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'nome': nome};
  }
}