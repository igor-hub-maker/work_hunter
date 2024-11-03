import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/pages/auth/login/login_screen.dart';
import 'package:work_hunter/pages/main/main_screen.dart';
import 'package:work_hunter/services/shared_prefs/shared_prefs_service.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/onboarding.png',
                  // fit: BoxFit.cover,
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Colors.white54,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () async {
                      await Injector.appInstance.get<SharedPrefsService>().settIsFirstLaunch(false);
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => const MainScreen()));
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Я шукаю роботу",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        "Я надаю роботу",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
