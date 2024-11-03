import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hunter/models/job.dart';
import 'package:work_hunter/pages/create_job/create_job_cubit.dart';
import 'package:work_hunter/pages/create_job/create_job_state.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({Key? key}) : super(key: key);

  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final screenCubit = CreateJobCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateJobCubit, CreateJobState>(
        bloc: screenCubit,
        listener: (BuildContext context, CreateJobState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, CreateJobState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CreateJobState state) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            children: [
              Transform.translate(
                offset: const Offset(-15, 0),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
            ],
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: screenCubit.getImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.maxFinite,
                height: 200,
                color: Colors.grey,
                child: state.image != null
                    ? Image.memory(
                        state.image!,
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.grey[800],
                          ),
                          Text(
                            "Додати картинку",
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Заголовок*",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            onChanged: (value) {
              screenCubit.title = value;
              screenCubit.checkIsCanCreateJob();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Опис*",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            maxLines: 5,
            onChanged: (value) {
              screenCubit.description = value;
              screenCubit.checkIsCanCreateJob();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Опис про зарплату",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          TextField(
            onChanged: (value) {
              screenCubit.salary = value.isEmpty ? null : value;
              screenCubit.checkIsCanCreateJob();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Місце",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              Checkbox(
                  value: screenCubit.isPlaceSameAsProfile,
                  onChanged: (value) {
                    setState(
                      () {
                        screenCubit.isPlaceSameAsProfile = value ?? true;
                      },
                    );
                    screenCubit.checkIsCanCreateJob();
                  }),
              const Flexible(
                child: Text(
                  "Місце співпадає з дизлокацією фірми",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !screenCubit.isPlaceSameAsProfile,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    screenCubit.place = value.isEmpty ? null : value;
                    screenCubit.checkIsCanCreateJob();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          IgnorePointer(
            ignoring: !(state.canCreate ?? false),
            child: FilledButton(
              onPressed: () => screenCubit.createJob(context),
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: state.canCreate ?? false ? null : Colors.grey),
              child: const Text(
                "Створити ваканцію",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
