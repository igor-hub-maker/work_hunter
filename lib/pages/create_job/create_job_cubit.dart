import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injector/injector.dart';
import 'package:work_hunter/managers/auth/auth_manager.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/models/job.dart';
import 'package:work_hunter/pages/create_job/create_job_state.dart';

class CreateJobCubit extends Cubit<CreateJobState> {
  CreateJobCubit() : super(CreateJobState(isLoading: true));

  String title = "", description = "";
  String? salary, place;
  bool isPlaceSameAsProfile = true;

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      // TODO your code here

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.gallery);
    emit(state.copyWith(image: await response?.readAsBytes()));
  }

  void checkIsCanCreateJob() {
    emit(state.copyWith(
      canCreate: title.isNotEmpty &&
          description.isNotEmpty &&
          (!isPlaceSameAsProfile ? place?.isNotEmpty ?? false : true),
    ));
  }

  Future<void> createJob(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final injector = Injector.appInstance;
    final jobManager = injector.get<JobManager>();
    final userId = injector.get<AuthManager>().getUserUid()!;
    String? imageUrl;
    if (state.image != null) {
      imageUrl = await jobManager.uploadJobImage(state.image!);
    }
    final job = Job(
      documentId: "",
      title: title,
      description: description,
      ownerId: userId,
      salary: salary,
      place: place,
      image: imageUrl,
    );
    await jobManager.createJob(job);
    Navigator.pop(context);
  }
}
