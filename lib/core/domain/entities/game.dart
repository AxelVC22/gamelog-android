import 'package:flutter/foundation.dart';

@immutable
class Game {
  final int id;
  final String name;
  final String description;
  final double rating;

  const Game ({
    required this.id,
    required this.name,
    required this.description,
    required this.rating
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
        name: json['nombre'] as String,
      description: json['descripcion'] as String,
      rating: json['calificacion'] as double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
    };
  }
}