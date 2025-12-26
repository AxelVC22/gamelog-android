import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../auth/providers/auth_providers.dart';
part 'review_management_providers.g.dart';


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
ReviewManagementRepository reviewManagementRepository(
    Ref ref,
    ) {
  return ReviewManagementRepositoryImpl(
    ref.read(apiKeyProvider),
    ref.watch(secureStorageProvider),
    ref.watch(dioProvider),
  );
}
