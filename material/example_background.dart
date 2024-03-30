import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 55, 29, 100), Color.fromARGB(255,20, 47, 114)],
            )
         ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("AppBar", style: TextStyle(color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 24, 28, 75),
          ),
          body: Center(
            child: Container(
              child: Text(
                "This is home page",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)
                ),
            ),
          ),
        ),
      )
    );
  }
}