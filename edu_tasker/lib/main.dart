import 'dart:io';

import 'package:edu_tasker_app/models/priority_model.dart';
import 'package:edu_tasker_app/models/routine_model.dart';
import 'package:edu_tasker_app/page/home_page.dart';
import 'package:edu_tasker_app/page/priority_page.dart';
import 'package:edu_tasker_app/page/routine_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for hive local storage
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // print(appDocumentDirectory.path);
  // Get the application's document directory    
  var appDir = await getApplicationDocumentsDirectory(); 
// Get the chosen sub-directory for Hive files
  await Hive.initFlutter();

  //register adapter
  
  Hive.registerAdapter(PriorityAdapter());
  Hive.registerAdapter(RoutineAdapter());
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
        builder: (context, state) => const HomePage(), //HomePage()
      ),
      GoRoute(
        path: "/routine",
        builder: (context, state) => const RoutinePage(),
      ),
      GoRoute(path: "/priority",
      builder: (context, state) => const PriorityPage(),)

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

