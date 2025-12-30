import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../../network/dio_client.dart';
import '../auth/auth_providers.dart';
part 'reviews_providers.g.dart';


@riverpod
String apiKey(Ref ref) {
  return dotenv.env['RAWG_API_KEY']!;
}

@riverpod
Dio dioRawg(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseRawgUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    ),
  );
}

@riverpod
ReviewsRepository reviewManagementRepository(
    Ref ref,
    ) {
  return ReviewsRepositoryImpl(
    ref.watch(dioProvider),
  );
}
