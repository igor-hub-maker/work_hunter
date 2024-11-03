class RegisterState {
  final bool isLoading;
  final bool? canCreateAccount;
  final String? error;

  const RegisterState({this.isLoading = false, this.error, this.canCreateAccount});

  RegisterState copyWith({
    bool? isLoading,
    String? error,
    bool? canCreateAccount,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      canCreateAccount: canCreateAccount ?? this.canCreateAccount,
    );
  }
}
