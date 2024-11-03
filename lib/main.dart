import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/IoC/composition_root.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/user/user_manager.dart';
import 'package:work_hunter/pages/create_user/create_user_screen.dart';
import 'package:work_hunter/pages/main/main_screen.dart';
import 'package:work_hunter/pages/onboarding/onboarding_screen.dart';
import 'package:work_hunter/services/shared_prefs/shared_prefs_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  CompositionRoot.initialize();

  runApp(MainApp(
    home: await getHomeScreen(),
  ));
}

Future<Widget> getHomeScreen() async {
  final injector = Injector.appInstance;
  final userId = injector.get<AuthManager>().getUserUid();
  // injector.get<AuthManager>().logout();
  // await injector.get<SharedPrefsService>().settIsFirstLaunch(true);

  final isFirstLaunch = await injector.get<SharedPrefsService>().getIsFirstLaunch();
  if (isFirstLaunch && userId == null) {
    return const OnboardingScreen();
  }

  if (userId != null) {
    final user = await injector.get<UserManager>().getUserByUId(userId);
    if (user == null) {
      return const CreateUserScreen();
    }
  }

  return const MainScreen();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home,
    );
  }
}
