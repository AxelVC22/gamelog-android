import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/dio_client.dart';
import '../../repositories/notifications/notifications_repository_implementation.dart';
part 'notifications_providers.g.dart';

@riverpod
NotificationsRepositoryImpl notificationsRepository(
    Ref ref,
    ) {
  return NotificationsRepositoryImpl(

      ref.watch(dioProvider));
}
