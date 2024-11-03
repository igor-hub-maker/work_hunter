import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/pages/create_job/create_job_screen.dart';
import 'package:work_hunter/pages/job_search/job_search_screen.dart';
import 'package:work_hunter/pages/main/items/job_item_component.dart';
import 'package:work_hunter/pages/main/main_cubit.dart';
import 'package:work_hunter/pages/main/main_state.dart';
import 'package:work_hunter/pages/user/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screenCubit = MainCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      bloc: screenCubit,
      listener: (BuildContext context, MainState state) {
        if (state.error != null) {
          // TODO your code here
        }
      },
      builder: (BuildContext context, MainState state) {
        if (state.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: buildBody(state),
          appBar: buildAppBar(state),
        );
      },
    );
  }

  Widget buildBody(MainState state) {
    return RefreshIndicator(
      onRefresh: screenCubit.getJobs,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: List.generate(
          state.jobs?.length ?? 0,
          (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: JobItemComponent(
              job: state.jobs![index],
              userId: screenCubit.userId,
              ondescriptionClosed: () => screenCubit.getJobs(),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(MainState state) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        "Work Hunter",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => const JobSearchScreen())),
          icon: const Icon(Icons.search_rounded),
        ),
        if (state.isLogedIn ?? false)
          IconButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const UserScreen())),
            icon: const Icon(Icons.supervised_user_circle_rounded),
          ),
        if (state.isLogedIn ?? false)
          IconButton.filled(
            onPressed: () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const CreateJobScreen()));
              screenCubit.getJobs();
            },
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
