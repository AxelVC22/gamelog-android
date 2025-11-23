import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';

import '../use_cases/logout_use_case.dart';

final logoutControllerProvider =
    NotifierProvider<LogoutController, AsyncValue<LogoutResponse?>>(
      LogoutController.new,
    );

class LogoutController extends Notifier<AsyncValue<LogoutResponse?>> {
  late final LogoutUseCase _logoutUseCase;

  @override
  AsyncValue<LogoutResponse?> build() {
    final repo = ref.read(authRepositoryProvider);
    _logoutUseCase = LogoutUseCase(repo);
    return const AsyncData(null);
  }

  Future<LogoutResponse?> logout(String email) async {
    state = const AsyncLoading();

    final result = await _logoutUseCase(email);

    return result.fold(
        (f) {
          state = AsyncError(f, StackTrace.current);
          return null;
        },
        (r) {
          state = AsyncData(r);
          return r;
        }
    );
  }

}
