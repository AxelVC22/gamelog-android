import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/providers/auth/auth_providers.dart';
import 'package:gamelog/core/data/repositories/users/users_repository.dart';
import 'package:gamelog/core/data/repositories/users/users_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_providers.g.dart';


@Riverpod(keepAlive: true)
UsersRepository userManagementRepository(UserManagementRepositoryRef ref) {
  return UsersRepositoryImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider)
  );
}

