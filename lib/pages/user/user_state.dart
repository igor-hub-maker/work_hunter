import 'package:work_hunter/models/job_with_user.dart';
import 'package:work_hunter/models/user.dart';

class UserState {
  final bool isLoading;
  final String? error;
  final User? user;
  final List<JobWithUser>? userJobs;

  const UserState({this.isLoading = false, this.error, this.user, this.userJobs});

  UserState copyWith({bool? isLoading, String? error, User? user, List<JobWithUser>? userJobs}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      userJobs: userJobs ?? this.userJobs,
    );
  }
}
