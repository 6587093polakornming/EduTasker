import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          appBar: getAppBar(),
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

  AppBar getAppBar() {
    return AppBar(
          actions: [
            IconButton(icon: Icon(Icons.settings, color: Colors.white, size: 40.0) , onPressed: (){})
          ],
          centerTitle: true,
          title: Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              shape: BoxShape.rectangle,
              color: Colors.white,),
            child: Center(
              child: Text("Name", 
              style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          leading: Container(
            // color: Colors.red,
            margin:EdgeInsets.only(left: 8.00, bottom: 8.00, top: 10.00),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/default_avatar.png',),
              // radius: 200.0,
              ),
          ),
          backgroundColor: Color.fromARGB(255, 24, 28, 75),
        );
  }
}