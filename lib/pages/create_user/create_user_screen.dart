import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/pages/create_user/create_user_cubit.dart';
import 'package:work_hunter/pages/create_user/create_user_state.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final screenCubit = CreateUserCubit();
  late final TextEditingController nameController,
      companyNameController,
      adressController,
      emailController,
      phoneNumberController;

  bool isTextEditingControllersInitialized = false;

  @override
  void initState() {
    screenCubit.loadInitialData(widget.isEdit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Редагування" : "Раєстрація",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<CreateUserCubit, CreateUserState>(
        bloc: screenCubit,
        listener: (BuildContext context, CreateUserState state) {
          if (state.error != null) {
            log(state.error!);
          }
        },
        builder: (BuildContext context, CreateUserState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (!isTextEditingControllersInitialized) {
            nameController = TextEditingController(text: screenCubit.name);
            companyNameController = TextEditingController(text: screenCubit.companyName);
            adressController = TextEditingController(text: screenCubit.adress);
            emailController = TextEditingController(text: screenCubit.email);
            phoneNumberController = TextEditingController(text: screenCubit.phoneNumber);
            isTextEditingControllersInitialized = true;
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CreateUserState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      //name: name, adress: adress, phoneNumber: phoneNumber, email: email
      children: [
        Text(
          "ПІБ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextField(
          controller: nameController,
          onChanged: (value) {
            screenCubit.name = value;
            screenCubit.checkIsCanCreate();
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        ),
        const SizedBox(height: 20),
        Text(
          "Назва компанії",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextField(
          controller: companyNameController,
          onChanged: (value) {
            screenCubit.companyName = value;
            screenCubit.checkIsCanCreate();
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        ),
        const SizedBox(height: 20),
        Text(
          "Адреса",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextField(
          controller: adressController,
          onChanged: (value) {
            screenCubit.adress = value;
            screenCubit.checkIsCanCreate();
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        ),
        const SizedBox(height: 20),
        Text(
          "Email для звʼязку",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            screenCubit.email = value;
            screenCubit.checkIsCanCreate();
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        ),
        const SizedBox(height: 20),
        Text(
          "Номер телефону для звʼязку",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextField(
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            screenCubit.phoneNumber = value;
            screenCubit.checkIsCanCreate();
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        ),
        const SizedBox(height: 20),
        IgnorePointer(
          ignoring: !(state.canCreate ?? false),
          child: FilledButton(
            onPressed: () =>
                widget.isEdit ? screenCubit.editUser(context) : screenCubit.createUser(context),
            style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: state.canCreate ?? true ? null : Colors.grey),
            child: Text(
              widget.isEdit ? "Змінити акаунт" : "Створити акаунт",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
