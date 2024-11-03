import 'dart:typed_data';

import 'package:work_hunter/models/job.dart';

abstract class JobManager {
  Future<List<Job>> getJobs();
  Future<void> createJob(Job job);
  Future<List<Job>> searchJobs(String query);
  Future<String> uploadJobImage(Uint8List image);
  Future<List<Job>> getJobsByOwner(String ownerId);
  Future<void> deleteJob(String jobId);
}
