import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/providers/auth_providers.dart';
import '../repositories/follow_repository.dart';
import '../repositories/follow_repository_implementation.dart';
part 'follows_providers.g.dart';

@riverpod
FollowRepository followRepository(
    Ref ref,
    ) {
  return FollowRepositoryImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider),
  );
}
