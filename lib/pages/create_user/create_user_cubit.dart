import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/models/user.dart';
import 'package:work_hunter/pages/create_user/create_user_state.dart';
import 'package:work_hunter/pages/main/main_screen.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserState(isLoading: true));
  late final UserManager userManager;

  late String userId;

  String name = '', companyName = '', adress = '', email = '', phoneNumber = '';

  Future<void> loadInitialData(bool isEdit) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final injector = Injector.appInstance;
      final authManager = injector.get<AuthManager>();
      userManager = injector.get<UserManager>();
      userId = authManager.getUserUid()!;

      if (isEdit) {
        final user = (await injector.get<UserManager>().getUserByUId(userId))!;
        name = user.name;
        adress = user.adress;
        phoneNumber = user.phoneNumber;
        email = user.email;
        companyName = user.companyName;
        checkIsCanCreate();
      }

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  void checkIsCanCreate() {
    emit(state.copyWith(
      canCreate: name.isNotEmpty &&
          companyName.isNotEmpty &&
          adress.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty,
    ));
  }

  Future<void> createUser(BuildContext context) async {
    final user = User(
        uId: userId,
        name: name,
        adress: adress,
        phoneNumber: phoneNumber,
        email: email,
        companyName: companyName);
    await userManager.createUser(user);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  Future<void> editUser(BuildContext context) async {
    final user = User(
        uId: userId,
        name: name,
        adress: adress,
        phoneNumber: phoneNumber,
        email: email,
        companyName: companyName);
    await userManager.editUser(user);
    Navigator.pop(context, user);
  }
}
