import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/models/job_with_user.dart';
import 'package:work_hunter/pages/job_search/job_search_state.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  JobSearchCubit() : super(const JobSearchState(isLoading: true));

  late final JobManager jobManager;
  late final UserManager userManager;
  late final String? userId;
  String searchString = "";

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final injector = Injector.appInstance;
      jobManager = injector.get<JobManager>();
      userManager = injector.get<UserManager>();
      userId = injector.get<AuthManager>().getUserUid();

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> search(String query) async {
    searchString = query;
    emit(state.copyWith(isLoading: true));
    final jobs = await jobManager.searchJobs(query);
    final jobsWithUser = [
      for (var job in jobs)
        JobWithUser(job: job, user: (await userManager.getUserByUId(job.ownerId))!)
    ];
    emit(state.copyWith(jobs: jobsWithUser, isLoading: false));
  }
}
