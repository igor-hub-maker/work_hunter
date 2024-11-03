import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_hunter/managers/job/job_manager.dart';
import 'package:work_hunter/models/job_with_user.dart';

class JobDescriptionScreen extends StatelessWidget {
  const JobDescriptionScreen({super.key, required this.job, this.userId});

  final JobWithUser job;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          job.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (userId == job.ownerId)
            IconButton(
              onPressed: () async {
                final isConfiremd = await showAdaptiveDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: const Text("Ви впевнені?"),
                    content: const Text("Ви впевнені що хочете видалити цю ваканцію?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false), child: const Text("Ні")),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true), child: const Text("Так")),
                    ],
                  ),
                );
                if (isConfiremd != true) {
                  return;
                }
                await Injector.appInstance.get<JobManager>().deleteJob(job.documentId);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          if (job.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 300,
                width: double.maxFinite,
                child: Image.network(
                  job.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                  job.user.companyName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.description,
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
                  job.description,
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
                  job.place ?? job.user.adress,
                ),
              ),
            ],
          ),
          if (job.salary != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
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
                    job.salary!,
                  ),
                ),
              ],
            ),
          ],
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
                child: GestureDetector(
                  onTap: () async {
                    final res = await launchUrl(Uri.parse("tel:${job.user.phoneNumber}"));
                    if (!res) {
                      Clipboard.setData(ClipboardData(text: job.user.phoneNumber));
                    }
                  },
                  child: Text(
                    job.user.phoneNumber,
                    style: const TextStyle(decoration: TextDecoration.underline),
                  ),
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
                child: GestureDetector(
                  onTap: () async {
                    final res = await launchUrl(Uri.parse("mailto:${job.user.email}"));
                    if (!res) {
                      Clipboard.setData(ClipboardData(text: job.user.email));
                    }
                  },
                  child: Text(
                    job.user.email,
                    style: const TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
