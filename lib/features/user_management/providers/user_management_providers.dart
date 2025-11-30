import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_management_providers.g.dart';


@Riverpod(keepAlive: true)
UserManagementRepository userManagementRepository(UserManagementRepositoryRef ref) {
  return UserManagementRepositoryImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider)
  );
}

