import 'package:work_hunter/models/job_with_user.dart';

class JobSearchState {
  final bool isLoading;
  final String? error;
  final List<JobWithUser>? jobs;

  const JobSearchState({
    this.isLoading = false,
    this.error,
    this.jobs,
  });

  JobSearchState copyWith({
    bool? isLoading,
    String? error,
    List<JobWithUser>? jobs,
  }) {
    return JobSearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      jobs: jobs ?? this.jobs,
    );
  }
}
