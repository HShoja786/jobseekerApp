import 'dart:async';
import '../models/job.dart';

class MockApi {
  static Future<List<Job>> fetchJobs({String? query, String? location}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final now = DateTime.now();
    List<Job> jobs = [
      Job(
        id: '1',
        title: 'Flutter Developer',
        company: 'Acme Corp',
        location: 'Remote',
        type: 'Full-time',
        description:
            'Develop mobile apps using Flutter. Work with cross-functional teams.',
        postedAt: now.subtract(const Duration(days: 2)),
      ),
      Job(
        id: '2',
        title: 'Backend Engineer',
        company: 'DataWorks',
        location: 'London, UK',
        type: 'Part-time',
        description: 'Design APIs and services. Experience with Node or Go.',
        postedAt: now.subtract(const Duration(days: 4)),
      ),
      Job(
        id: '3',
        title: 'Product Designer',
        company: 'StudioX',
        location: 'Berlin, DE',
        type: 'Contract',
        description:
            'Design interfaces and user experiences for mobile and web.',
        postedAt: now.subtract(const Duration(days: 1)),
      ),
    ];

    if (query != null && query.trim().isNotEmpty) {
      jobs = jobs
          .where(
            (j) =>
                j.title.toLowerCase().contains(query.toLowerCase()) ||
                j.company.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    if (location != null && location.trim().isNotEmpty) {
      jobs = jobs
          .where(
            (j) => j.location.toLowerCase().contains(location.toLowerCase()),
          )
          .toList();
    }
    return jobs;
  }

  static Future<Job?> fetchJobById(String id) async {
    final jobs = await fetchJobs();
    return jobs.firstWhere(
      (j) => j.id == id,
      orElse: () => Job(
        id: "0",
        title: "",
        company: "",
        location: "",
        type: "",
        description: "",
        postedAt: DateTime(2026),
      ),
    );
  }
}
