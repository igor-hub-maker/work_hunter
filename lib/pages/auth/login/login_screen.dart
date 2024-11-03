import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_hunter/common/image_constants.dart';
import 'package:work_hunter/pages/auth/login/login_cubit.dart';
import 'package:work_hunter/pages/auth/login/login_state.dart';
import 'package:work_hunter/pages/auth/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final screenCubit = LoginCubit();

  bool canLogin = false;
  bool shouldHidePassword = true;

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: screenCubit,
        listener: (BuildContext context, LoginState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(LoginState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Icon(
              Icons.work_outline_rounded,
              size: 80,
            ),
          ),
          const Center(
            child: Text(
              "Увійти",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ),
          const Text(
            "Пошта",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            onChanged: (value) {
              screenCubit.emailText = value;

              setState(() {
                canLogin = screenCubit.passwordText.isNotEmpty && screenCubit.emailText.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Пароль",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: shouldHidePassword,
            onChanged: (value) {
              screenCubit.passwordText = value;

              setState(() {
                canLogin = screenCubit.passwordText.isNotEmpty && screenCubit.emailText.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  shouldHidePassword = !shouldHidePassword;
                }),
                icon: Icon(
                  shouldHidePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 20),
          IgnorePointer(
            ignoring: !canLogin,
            child: FilledButton(
              onPressed: () => screenCubit.login(context),
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: canLogin ? null : Colors.grey //MediaQuery.of(context).,
                  ),
              child: const Text(
                "Увійти",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Row(
          //   children: [
          //     const Expanded(
          //       child: Divider(),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 10),
          //       child: const Text(
          //         "або",
          //         style: TextStyle(fontSize: 18),
          //       ),
          //     ),
          //     const Expanded(
          //       child: Divider(),
          //     ),
          //   ],
          // ),
          const Center(
            child: Text(
              "Немає аккаунту?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
            child: const Text("Зареєструватися"),
          ),
        ],
      ),
    );
  }
}
