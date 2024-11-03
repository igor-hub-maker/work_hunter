import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/pages/job_search/job_search_cubit.dart';
import 'package:work_hunter/pages/job_search/job_search_state.dart';
import 'package:work_hunter/pages/main/items/job_item_component.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({Key? key}) : super(key: key);

  @override
  _JobSearchScreenState createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final screenCubit = JobSearchCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<JobSearchCubit, JobSearchState>(
        bloc: screenCubit,
        listener: (BuildContext context, JobSearchState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, JobSearchState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: TextField(
        onChanged: screenCubit.search,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget buildBody(JobSearchState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      children: List.generate(
        state.jobs?.length ?? 0,
        (index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: JobItemComponent(
            job: state.jobs![index],
            userId: screenCubit.userId,
            ondescriptionClosed: () => screenCubit.search(screenCubit.searchString),
          ),
        ),
      ),
    );
  }
}
