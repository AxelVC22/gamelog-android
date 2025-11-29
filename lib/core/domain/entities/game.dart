import 'package:flutter/foundation.dart';

@immutable
class Game {
  final int id;
  final String slug;
  final String name;
  final String? description;
  final int? metacritic;
  final String? released;
  final String? backgroundImage;
  final String? backgroundImageAdditional;
  final String? website;
  final double rating;
  final int ratingTop;

  const Game({
    required this.id,
    required this.slug,
    required this.name,
    this.description,
    this.metacritic,
    this.released,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.website,
    required this.rating,
    required this.ratingTop,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      metacritic: json['metacritic'] as int?,
      released: json['released'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageAdditional: json['background_image_additional'] as String?,
      website: json['website'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingTop: json['rating_top'] as int? ?? 0,
    );
  }
}
