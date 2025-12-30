import 'package:flutter_riverpod/flutter_riverpod.dart';

final recoverPasswordStepControllerProvider =
StateNotifierProvider<RecoverPasswordStepController, int>(
      (ref) => RecoverPasswordStepController(),
);

class RecoverPasswordStepController extends StateNotifier<int> {
  RecoverPasswordStepController() : super(1);

  void next() {
    state = state + 1;
  }

  void previous() {
    if (state > 1) {
      state = state - 1;
    }
  }

  void goTo(int step) {
    state = step;
  }
}
