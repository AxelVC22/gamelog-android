import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/register_user_request.dart';
import '../uses_cases/register_user_use_case.dart';
import 'auth_providers.dart';

final registerControllerProvider =
NotifierProvider<RegisterController, AsyncValue<String?>>(
  RegisterController.new,
);

class RegisterController extends Notifier<AsyncValue<String?>> {
  @override
  AsyncValue<String?> build() {
    return const AsyncData(null);
  }

  Future<void> register(RegisterUserRequest request) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final useCase = RegisterUserUseCase(repo);

    final result = await useCase(request);

    result.fold(
          (failure) => state = AsyncError(failure.message, StackTrace.current),
          (message) => state = AsyncData(message),
    );
  }
}
