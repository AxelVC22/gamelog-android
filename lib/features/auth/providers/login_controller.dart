import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/auth/uses_cases/login_use_case.dart';

import '../models/login_response.dart';

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

  Future<LoginResponse?> login(LoginRequest req) async {
    state = const AsyncLoading();

    final result = await _loginUseCase(req);

    return result.fold(
          (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
          (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }

}
