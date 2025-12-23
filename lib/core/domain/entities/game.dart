import 'package:flutter/foundation.dart';

@immutable
class Game {
  final int id;
  final String? slug;
  final String name;
  final String? description;
  final int? metacritic;
  final String? released;
  final String? backgroundImage;
  final String? backgroundImageAdditional;
  final String? website;
  final double rating;
  final int ratingTop;
  final int? totalRatings;

  const Game({
    required this.id,
     this.slug,
    required this.name,
    this.description,
    this.metacritic,
    this.released,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.website,
    required this.rating,
    required this.ratingTop,
    this.totalRatings
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        id: (json['id'] as int?) ?? (json['idJuego'] as int),
      slug: json['slug'] as String?,
      name: (json['name'] as String?) ?? (json['nombre'] as String),
      description: json['description'] as String?,
      metacritic: json['metacritic'] as int?,
      released: json['released'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageAdditional: json['background_image_additional'] as String?,
      website: json['website'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingTop: json['rating_top'] as int? ?? 0,
      totalRatings: json['totalReseñas'] as int? ?? 0
    );
  }

  Game copyWith({
    int? id,
    String? slug,
    String? name,
    String? description,
    int? metacritic,
    String? released,
    String? backgroundImage,
    String? backgroundImageAdditional,
    String? website,
    double? rating,
    int? ratingTop,
    int? totalRatings,
  }) {
    return Game(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      metacritic: metacritic ?? this.metacritic,
      released: released ?? this.released,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      backgroundImageAdditional:
      backgroundImageAdditional ?? this.backgroundImageAdditional,
      website: website ?? this.website,
      rating: rating ?? this.rating,
      ratingTop: ratingTop ?? this.ratingTop,
      totalRatings: totalRatings ?? this.totalRatings,
    );
  }
}
