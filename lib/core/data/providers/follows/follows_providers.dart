import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/dio_client.dart';
import '../../repositories/follows/follow_repository.dart';
import '../../repositories/follows/follow_repository_implementation.dart';
part 'follows_providers.g.dart';

@riverpod
FollowRepository followRepository(
    Ref ref,
    ) {
  return FollowRepositoryImpl(
    ref.watch(dioProvider)
  );
}
