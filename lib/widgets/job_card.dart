/// FILE: lib/widgets/job_card.dart
import 'package:flutter/material.dart';
import '../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;

  const JobCard({Key? key, required this.job, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(job.type, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              '${job.postedAt.difference(DateTime.now()).inDays.abs()}d',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
