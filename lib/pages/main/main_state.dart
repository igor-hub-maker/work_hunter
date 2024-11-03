import 'package:work_hunter/models/job_with_user.dart';

class MainState {
  final bool isLoading;
  final bool? isLogedIn;
  final String? error;
  final List<JobWithUser>? jobs;

  const MainState({
    this.isLoading = false,
    this.error,
    this.isLogedIn,
    this.jobs,
  });

  MainState copyWith({
    bool? isLoading,
    String? error,
    bool? isLogedIn,
    List<JobWithUser>? jobs,
  }) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isLogedIn: isLogedIn ?? this.isLogedIn,
      jobs: jobs ?? this.jobs,
    );
  }
}
