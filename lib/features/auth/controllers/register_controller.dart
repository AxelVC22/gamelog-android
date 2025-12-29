import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/auth/register_user_reponse.dart';
import '../../../core/data/models/auth/register_user_request.dart';
import '../use_cases/register_user_use_case.dart';
import '../../../core/data/providers/auth/auth_providers.dart';

final registerControllerProvider =
    NotifierProvider<RegisterController, AsyncValue<RegisterUserResponse?>>(
      RegisterController.new,
    );

class RegisterController extends Notifier<AsyncValue<RegisterUserResponse?>> {
  late final RegisterUserUseCase _useCase;

  @override
  AsyncValue<RegisterUserResponse?> build() {
    final repo = ref.read(authRepositoryProvider);
    _useCase = RegisterUserUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> register(RegisterUserRequest req) async {
    state = const AsyncLoading();
    final result = await _useCase(req);
    state = result.fold(
      (f) => AsyncError(f, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
