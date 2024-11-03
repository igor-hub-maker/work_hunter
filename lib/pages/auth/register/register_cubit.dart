import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/common/constants.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/pages/auth/register/register_state.dart';
import 'package:work_hunter/pages/create_user/create_user_screen.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState(isLoading: true));

  late final AuthManager authManager;

  String email = "";
  String password = "";
  String repeatPassword = "";

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final injector = Injector.appInstance;
      authManager = injector.get<AuthManager>();

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  void checkIsCanCreateAccount() {
    emit(state.copyWith(
      canCreateAccount:
          Constants.emailReg.hasMatch(email) && password.isNotEmpty && password == repeatPassword,
    ));
  }

  Future<void> createAccount(BuildContext context) async {
    final isLogIned = await authManager.register(email, password);
    log(isLogIned.toString());
    if (isLogIned) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CreateUserScreen()));
    }
  }
}
