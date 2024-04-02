import 'package:edu_tasker_app/page/routine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


void main(List<String> args) {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, title: 'Flutter App', home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Global Var in _Myappstate

  // init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get data from database
    // Task_List =  ...;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 55, 29, 100),
          Color.fromARGB(255, 20, 47, 114)
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getAppBar(),
        body: Center(
          child: getBody(),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 40.0),
            onPressed: () {})
      ],
      title: Text("Summary"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 48, color: Colors.white),
        onPressed: () => {},
      ),
      backgroundColor: Color.fromARGB(255, 24, 28, 75),
    );
  }

  Column getBody() {
    return Column();
  }



}

// Class -----------------------------------------
class Priority {
  final String name = "";
  final String priority = "";

}

class Routine {
  final String name = "";
  final int count = 0;
  final String unit = "";

}

class Weekly {
  final String name = "" ;
  final DateTime date = DateTime.now();


}
