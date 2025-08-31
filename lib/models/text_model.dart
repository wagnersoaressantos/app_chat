import 'package:cloud_firestore/cloud_firestore.dart';

class TextModel {
  DateTime dataHora = DateTime.now();
  String text = "";
  String userId = "";
  String? grupoId;
  String nickname = "";

  TextModel({
    this.grupoId,
    required this.text,
    required this.userId,
    required this.nickname,
  });

  TextModel.fromJson(Map<String, dynamic> json) {
    dataHora = (json['data_hora'] as Timestamp).toDate();
    grupoId = json['grupoId'];
    text = json['text'];
    userId = json['user_id'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_hora'] = Timestamp.fromDate(dataHora);
    data['text'] = text;
    data['user_id'] = userId;
    data['grupoId'] = grupoId;
    data['nickname'] = nickname;
    return data;
  }
}
