import 'package:flutter/material.dart';
import '../services/mock_api.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Job> _jobs = [];
  var _loading = true;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({String? q}) async {
    setState(() => _loading = true);
    _jobs = await MockApi.fetchJobs(query: q);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ProfileScreen.routeName),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search jobs or companies',
                    ),
                    onSubmitted: (v) => _load(q: v),
                  ),
                ),
                IconButton(
                  onPressed: () => _load(q: _searchCtrl.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _load,
                    child: _jobs.isEmpty
                        ? const Center(child: Text('No jobs found'))
                        : ListView.builder(
                            itemCount: _jobs.length,
                            itemBuilder: (ctx, i) => JobCard(
                              job: _jobs[i],
                              onTap: () => Navigator.of(context).pushNamed(
                                JobDetailScreen.routeName,
                                arguments: _jobs[i].id,
                              ),
                            ),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
