import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/models/user.dart';
import 'package:work_hunter/pages/main/items/job_item_component.dart';
import 'package:work_hunter/pages/user/user_cubit.dart';
import 'package:work_hunter/pages/user/user_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final screenCubit = UserCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
    //   phoneNumber: phoneNumber, email: email,
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      bloc: screenCubit,
      listener: (BuildContext context, UserState state) {
        if (state.error != null) {
          // TODO your code here
        }
      },
      builder: (BuildContext context, UserState state) {
        if (state.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.user!.companyName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: buildBody(state),
        );
      },
    );
  }

  Widget buildBody(UserState state) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.person_3_sharp,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  state.user!.name,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.place_rounded,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  state.user!.adress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  state.user!.phoneNumber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.location_city,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  state.user!.email,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => screenCubit.editUser(context),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Змінити акаунт",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(),
          const Text(
            "Ваканції",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.userJobs?.length ?? 0,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: JobItemComponent(
                job: state.userJobs![index],
                userId: state.user?.uId,
                ondescriptionClosed: () => screenCubit.getUserJobs(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
