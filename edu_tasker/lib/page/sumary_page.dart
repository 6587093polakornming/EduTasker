import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: SummaryPage()));
}

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  // Global Var in _SummaryPagestate
  int body_state = 0;
  List<String> menu_option = ["All", "Priority", "Routine"];

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
        body: getBody(),
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
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        menu()
      ],
    );
  }

  Container menu() {
    return Container(
      height: 40,
      child: ListView.builder(
          itemCount: menu_option.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                child: TextButton(
                  onPressed: () => chaneSummary(index),
                  child: Text(
                    menu_option[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 24, 28, 75),
                  )),
                ));
          }),
    );
    // return Text("text");
  }

  void chaneSummary(index) {
    body_state = index;
    print(body_state);
    setState(() {});
  }
}
