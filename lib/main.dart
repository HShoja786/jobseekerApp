import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/job.dart';
import 'services/mock_api.dart';
import 'screens/home_screen.dart';
import 'screens/job_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/app_state.dart';

/* 

Author : Hafeezullah Shoja

*/

void main() {
  runApp(const JobSeekerApp());
}

class JobSeekerApp extends StatelessWidget {
  const JobSeekerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Job Seeker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const AuthScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          JobDetailScreen.routeName: (ctx) => const JobDetailScreen(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
        },
      ),
    );
  }
}
