import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/pages/auth/login/login_state.dart';
import 'package:work_hunter/pages/create_user/create_user_screen.dart';
import 'package:work_hunter/pages/main/main_screen.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(isLoading: true));

  late final AuthManager authManager;
  late final UserManager userManager;

  String emailText = "";
  String passwordText = "";

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final injector = Injector.appInstance;
      authManager = injector.get<AuthManager>();
      userManager = injector.get<UserManager>();

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> login(BuildContext context) async {
    final isLogIned = await authManager.login(emailText, passwordText);
    log(isLogIned.toString());
    if (!isLogIned) {
      return;
    }

    final uId = authManager.getUserUid()!;
    final user = await userManager.getUserByUId(uId);
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const CreateUserScreen()));
      return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }
}
