import 'package:work_hunter/models/job.dart';
import 'package:work_hunter/models/user.dart';

class JobWithUser extends Job {
  JobWithUser({required Job job, required this.user})
      : super(
          description: job.description,
          title: job.title,
          ownerId: job.ownerId,
          salary: job.salary,
          image: job.image,
          place: job.place,
          documentId: job.documentId,
        );

  final User user;
}
