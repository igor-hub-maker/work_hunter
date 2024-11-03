import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/pages/auth/login/login_screen.dart';
import 'package:work_hunter/pages/auth/register/register_cubit.dart';
import 'package:work_hunter/pages/auth/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final screenCubit = RegisterCubit();

  bool shouldHidePassword = true;

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        bloc: screenCubit,
        listener: (BuildContext context, RegisterState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, RegisterState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(RegisterState state) {
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
              "Реєстрація",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ),
          const Text(
            "Пошта",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            onChanged: (value) {
              screenCubit.email = value;
              screenCubit.checkIsCanCreateAccount();
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
            onChanged: (value) {
              screenCubit.password = value;
              screenCubit.checkIsCanCreateAccount();
            },
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: shouldHidePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  shouldHidePassword = !shouldHidePassword;
                }),
                icon: Icon(
                  shouldHidePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Повторити пароль",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            onChanged: (value) {
              screenCubit.repeatPassword = value;
              screenCubit.checkIsCanCreateAccount();
            },
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: shouldHidePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  shouldHidePassword = !shouldHidePassword;
                }),
                icon: Icon(
                  shouldHidePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          IgnorePointer(
            ignoring: !(state.canCreateAccount ?? false),
            child: FilledButton(
              onPressed: () => screenCubit.createAccount(context),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: state.canCreateAccount ?? false ? null : Colors.grey,
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Створити аккаунт",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Вже є аккаунт?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            child: const Text("Увійти"),
          ),
        ],
      ),
    );
  }
}
