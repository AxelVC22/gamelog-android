import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/repositories/users/users_repository.dart';
import 'package:gamelog/core/data/repositories/users/users_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/dio_client.dart';

part 'users_providers.g.dart';


@riverpod
UsersRepository userManagementRepository(Ref ref) {
  return UsersRepositoryImpl(
    ref.watch(dioProvider)
  );
}

