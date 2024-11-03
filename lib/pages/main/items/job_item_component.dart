import 'package:flutter/material.dart';
import 'package:work_hunter/models/job_with_user.dart';
import 'package:work_hunter/pages/job_description/job_description_screen.dart';

class JobItemComponent extends StatelessWidget {
  const JobItemComponent({
    super.key,
    required this.job,
    this.userId,
    this.ondescriptionClosed,
  });

  final JobWithUser job;
  final String? userId;
  final void Function()? ondescriptionClosed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JobDescriptionScreen(
              job: job,
              userId: userId,
            ),
          ),
        );

        ondescriptionClosed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 150,
                  width: double.maxFinite,
                  child: Image.network(
                    job.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                job.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                job.user.companyName,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
