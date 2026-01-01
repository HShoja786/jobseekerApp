import 'package:flutter/foundation.dart';
import '../models/job.dart';

class AppState extends ChangeNotifier {
  String? userEmail;
  final List<Job> savedJobs = [];

  void signIn(String email) {
    userEmail = email;
    notifyListeners();
  }

  void signOut() {
    userEmail = null;
    notifyListeners();
  }

  void toggleSave(Job job) {
    if (savedJobs.any((j) => j.id == job.id)) {
      savedJobs.removeWhere((j) => j.id == job.id);
    } else {
      savedJobs.add(job);
    }
    notifyListeners();
  }

  bool isSaved(Job job) => savedJobs.any((j) => j.id == job.id);
}
