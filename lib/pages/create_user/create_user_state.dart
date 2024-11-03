class CreateUserState {
  final bool isLoading;
  final bool? canCreate;
  final String? error;

  const CreateUserState({
    this.isLoading = false,
    this.error,
    this.canCreate,
  });

  CreateUserState copyWith({
    bool? isLoading,
    String? error,
    bool? canCreate,
  }) {
    return CreateUserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      canCreate: canCreate ?? this.canCreate,
    );
  }
}
