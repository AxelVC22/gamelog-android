
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/notifications/models/retrieve_notifications_response.dart';
import 'package:gamelog/features/notifications/providers/notifications_providers.dart';
import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/statistics/providers/statistics_providers.dart';
import 'package:gamelog/features/statistics/use_cases/retrieve_revival_retro_statistics_use_case.dart';
import 'package:intl/intl.dart';

import '../use_cases/retrieve_notifications_use_case.dart';

final retrieveNotificationsControllerProvider =
NotifierProvider<RetrieveNotificationsController, AsyncValue<RetrieveNotificationsResponse?>>(
  RetrieveNotificationsController.new,
);

class RetrieveNotificationsController extends Notifier<AsyncValue<RetrieveNotificationsResponse?>> {
  late final RetrieveNotificationsUseCase _retrieveNotificationsUseCase;

  @override
  AsyncValue<RetrieveNotificationsResponse?> build() {
    final repo = ref.read(notificationsRepositoryProvider);

    _retrieveNotificationsUseCase = RetrieveNotificationsUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveNotifications(int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveNotificationsUseCase(idPlayer);

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}