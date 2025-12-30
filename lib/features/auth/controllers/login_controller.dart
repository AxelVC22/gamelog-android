import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/auth/login_request.dart';
import 'package:gamelog/core/data/providers/auth/auth_providers.dart';

import '../../../core/data/models/auth/login_response.dart';
import '../../../core/network/dio_client.dart';
import '../state/auth_state.dart';
import '../use_cases/login_use_case.dart';

final loginControllerProvider =
    NotifierProvider<LoginController, AsyncValue<LoginResponse?>>(
      LoginController.new,
    );

class LoginController extends Notifier<AsyncValue<LoginResponse?>> {
  late final LoginUseCase _loginUseCase;

  @override
  AsyncValue<LoginResponse?> build() {
    final repo = ref.read(authRepositoryProvider);
    _loginUseCase = LoginUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> login(LoginRequest req) async {
    state = const AsyncLoading();

    final result = await _loginUseCase(req);

    await result.fold(
          (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
          (response) async {
        if (response.accounts.isNotEmpty) {
          final account = response.accounts.first;

          ref.read(currentUserProvider.notifier).state = account;

          await ref.read(authStateProvider.notifier).persistUser(account);

          ref.read(authStateProvider.notifier).authenticated();
        }

        state = AsyncData(response);
      },
    );
  }
}