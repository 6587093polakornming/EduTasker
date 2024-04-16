import 'dart:io';
import 'package:edu_tasker_app/models/TimeOfDayAdapter.dart';
import 'package:edu_tasker_app/models/class_model.dart';
import 'package:edu_tasker_app/models/priority_model.dart';
import 'package:edu_tasker_app/models/routine_model.dart';
import 'package:edu_tasker_app/page/class_schedule_page.dart';
import 'package:edu_tasker_app/page/home_page.dart';
import 'package:edu_tasker_app/page/login_page.dart';
import 'package:edu_tasker_app/page/priority_page.dart';
import 'package:edu_tasker_app/page/routine_page.dart';
import 'package:edu_tasker_app/page/setting_page.dart';
import 'package:edu_tasker_app/page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:edu_tasker_app/page/sumary_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:edu_tasker_app/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Get the chosen sub-directory for Hive files
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //register adapter

  //Hive.deleteBoxFromDisk("EDUTASKER");
  //Hive.resetAdapters();
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(ClassAdapter());
  // Hive.registerAdapter(ClassAdapter()); // จาก g.dart
  Hive.registerAdapter(PriorityAdapter());
  // Hive.deleteBoxFromDisk("EDUTASKER");
  var box = await Hive.openBox('EDUTASKER');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: [
      //TODO #1 Start ฺPage
      GoRoute(
        path: "/",
        builder: (context, state) => const LoginPage(), //LoginPage()
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => const HomePage(), //HomePage()
      ),
      GoRoute(
        path: "/routine",
        builder: (context, state) => const RoutinePage(),
      ),
      GoRoute(
        path: "/classSchedule",
        builder: (context, state) => const ClassSchedulePage(),
      ),
      GoRoute(
        path: "/priority",
        builder: (context, state) => const PriorityPage(),
      ),
      GoRoute(
        path: "/summary",
        builder: (context, state) => const SummaryPage(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: "/setting",
        builder: (context, state) => const SettingPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EduTasker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router, //home
    );
  }
}
