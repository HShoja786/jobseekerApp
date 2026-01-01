/// FILE: lib/screens/job_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_api.dart';
import '../models/job.dart';
import '../providers/app_state.dart';

class JobDetailScreen extends StatefulWidget {
  static const routeName = '/job';
  const JobDetailScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  Job? job;
  var _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments as String;
    _load(id);
  }

  Future<void> _load(String id) async {
    setState(() => _loading = true);
    job = await MockApi.fetchJobById(id);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(job?.title ?? 'Job'),
        actions: [
          if (job != null)
            IconButton(
              icon: Icon(
                appState.isSaved(job!) ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: () => appState.toggleSave(job!),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : job == null
          ? const Center(child: Text('Job not found'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job!.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${job!.company} • ${job!.location} • ${job!.type}'),
                    const SizedBox(height: 12),
                    Text(job!.description),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _apply(job!),
                      icon: const Icon(Icons.send),
                      label: const Text('Apply'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _apply(Job job) {
    // This is a placeholder: open application flow or external link.
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Apply'),
        content: const Text('Your application has been sent (mock).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
