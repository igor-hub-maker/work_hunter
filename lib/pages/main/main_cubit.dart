import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/models/job_with_user.dart';
import 'package:work_hunter/pages/main/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState(isLoading: true));

  late final JobManager jobManager;
  late final UserManager userManager;
  late final String? userId;

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final injector = Injector.appInstance;
      final authManager = injector.get<AuthManager>();
      jobManager = injector.get<JobManager>();
      userManager = injector.get<UserManager>();
      userId = authManager.getUserUid();

      await getJobs();
      emit(state.copyWith(isLoading: false, isLogedIn: userId != null));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getJobs() async {
    final jobs = await jobManager.getJobs();
    final jobsWithUser = [
      for (var job in jobs)
        JobWithUser(job: job, user: (await userManager.getUserByUId(job.ownerId))!)
    ];
    emit(state.copyWith(jobs: jobsWithUser));
  }
}
