import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';

class AuthManagerImpl implements AuthManager {
  final auth = FirebaseAuth.instance;

  @override
  Future<bool> login(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user != null;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user != null;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  String? getUserUid() {
    return auth.currentUser?.uid;
  }

  @override
  Future logout() {
    return auth.signOut();
  }
}
