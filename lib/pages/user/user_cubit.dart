import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/models/job_with_user.dart';
import 'package:work_hunter/models/user.dart';
import 'package:work_hunter/pages/create_user/create_user_screen.dart';
import 'package:work_hunter/pages/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(isLoading: true));
  late final UserManager userManager;
  late final JobManager jobManager;

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final injector = Injector.appInstance;
      final authManager = injector.get<AuthManager>();
      userManager = injector.get<UserManager>();
      jobManager = injector.get<JobManager>();

      final user = await userManager.getUserByUId(authManager.getUserUid()!);
      emit(state.copyWith(user: user));

      await getUserJobs();

      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getUserJobs() async {
    final jobs = await jobManager.getJobsByOwner(state.user!.uId);
    final jobsWithUser = jobs.map((e) => JobWithUser(job: e, user: state.user!)).toList();
    emit(state.copyWith(userJobs: jobsWithUser));
  }

  Future<void> editUser(BuildContext context) async {
    var user = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateUserScreen(isEdit: true),
      ),
    );

    if (user == null || user is! User) {
      user = await userManager.getUserByUId(state.user!.uId);
    }

    emit(state.copyWith(user: user));
  }
}
