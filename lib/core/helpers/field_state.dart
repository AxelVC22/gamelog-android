class FieldState {
  final String? error;
  final bool touched;

  const FieldState({
    this.error,
    this.touched = false,
  });

  bool get isValid => touched && error == null;

  FieldState copyWith({String? error, bool? touched}) {
    return FieldState(
      error: error,
      touched: touched ?? this.touched,
    );
  }
}