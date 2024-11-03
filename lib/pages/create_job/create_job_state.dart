import 'dart:typed_data';

class CreateJobState {
  final bool isLoading;
  final String? error;
  final bool? canCreate;
  final Uint8List? image;

  const CreateJobState({
    this.isLoading = false,
    this.error,
    this.canCreate,
    this.image,
  });

  CreateJobState copyWith({
    bool? isLoading,
    String? error,
    bool? canCreate,
    Uint8List? image,
  }) {
    return CreateJobState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      canCreate: canCreate ?? this.canCreate,
      image: image ?? this.image,
    );
  }
}
