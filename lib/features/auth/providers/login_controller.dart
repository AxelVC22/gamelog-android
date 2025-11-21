import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/models/login_request.dart';

import '../models/login_response.dart';
import '../repositories/auth_repository.dart';
import 'auth_providers.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<LoginResponse?>>(
      (ref) => LoginController(ref.watch(authRepositoryProvider)),
    );

class LoginController extends StateNotifier<AsyncValue<LoginResponse?>> {
  final AuthRepository repository;

  LoginController(this.repository) : super(const AsyncValue.data(null));

  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading();

    final result = await repository.login(request);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (loginResponse) => state = AsyncValue.data(loginResponse),
    );
  }
}
