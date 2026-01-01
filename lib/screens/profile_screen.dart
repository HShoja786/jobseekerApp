/// FILE: lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Signed in as: ${appState.userEmail ?? 'Guest'}'),
            const SizedBox(height: 12),
            const Text(
              'Saved jobs:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: appState.savedJobs.isEmpty
                  ? const Text('No saved jobs yet')
                  : ListView.builder(
                      itemCount: appState.savedJobs.length,
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(appState.savedJobs[i].title),
                        subtitle: Text(appState.savedJobs[i].company),
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                appState.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
