import 'package:confhub/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({
    required super.name,
    required super.duration,
  });

  // 📌 Método para convertir JSON a SessionModel
  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      name: json['name'],
      duration: json['duration'],
    );
  }

  // Método para convertir SessionModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
    };
  }

}
