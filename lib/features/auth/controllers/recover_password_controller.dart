import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/auth/recover_password_request.dart';
import 'package:gamelog/core/data/models/auth/recover_password_response.dart';
import 'package:gamelog/core/data/providers/auth/auth_providers.dart';

import '../use_cases/recover_password_use_case.dart';

final recoverPasswordControllerProvider =
    NotifierProvider<
      RecoverPasswordController,
      AsyncValue<RecoverPasswordResponse?>
    >(RecoverPasswordController.new);

class RecoverPasswordController
    extends Notifier<AsyncValue<RecoverPasswordResponse?>> {
  late final RecoverPasswordSendEmailUseCase _recoverPasswordUseCase;
  late final RecoverPasswordVerifyCodeUseCase _verifyCode;
  late final RecoverPasswordChangePasswordUseCase _changePassword;

  @override
  AsyncValue<RecoverPasswordResponse?> build() {
    final repo = ref.read(authRepositoryProvider);

    _recoverPasswordUseCase = RecoverPasswordSendEmailUseCase(repo);
    _verifyCode = RecoverPasswordVerifyCodeUseCase(repo);
    _changePassword = RecoverPasswordChangePasswordUseCase(repo);

    return const AsyncData(null);
  }

  Future<RecoverPasswordResponse?> sendEmail(RecoverPasswordRequest req) async {
    state = const AsyncLoading();

    final result = await _recoverPasswordUseCase(req);

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

  Future<void> verifyCode(RecoverPasswordRequest req) async {
    state = const AsyncLoading();
    final result = await _verifyCode(req);
    state = result.fold(
      (f) => AsyncError(f, StackTrace.current),
      (r) => AsyncData(r),
    );
  }

  Future<void> changePassword(RecoverPasswordRequest req) async {
    state = const AsyncLoading();
    final result = await _changePassword(req);
    state = result.fold(
      (f) => AsyncError(f, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
