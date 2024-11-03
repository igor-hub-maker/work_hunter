import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/models/job.dart';

class JobManagerImpl implements JobManager {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  final jobStore = FirebaseFirestore.instance.collection('jobs').withConverter(
        fromFirestore: (snapshots, _) => Job.fromJsonm(snapshots.data()!, snapshots.id),
        toFirestore: (Job job, _) => job.toJson(),
      );

  @override
  Future<void> createJob(Job job) {
    return jobStore.add(job);
  }

  @override
  Future<List<Job>> getJobs() async {
    final snapshots = await jobStore.get();
    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<Job>> searchJobs(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final filter = Filter.and(
      Filter('title', isGreaterThanOrEqualTo: query.toLowerCase()),
      Filter('title', isLessThanOrEqualTo: '$query\uf7ff'.toLowerCase()),
    );
    final snapshots = await jobStore.where(filter).get();
    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future<String> uploadJobImage(Uint8List image) async {
    final name = String.fromCharCodes(
        Iterable.generate(25, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
    final ref = FirebaseStorage.instance.ref("$name.png");
    final snapshot = await ref.putData(image);
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  @override
  Future<List<Job>> getJobsByOwner(String ownerId) async {
    final snapshots = await jobStore.where('ownerId', isEqualTo: ownerId).get();
    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> deleteJob(String jobId) {
    return jobStore.doc(jobId).delete();
  }
}
