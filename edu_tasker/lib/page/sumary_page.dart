import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:edu_tasker_app/models/priority_model.dart';
import 'package:edu_tasker_app/models/routine_model.dart';

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
  final _EDUTASKER = Hive.box('EDUTASKER');
  PriorityDatabase priorityDB = PriorityDatabase();
  RoutineDatabase routineDB = RoutineDatabase();

  // init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_EDUTASKER.get('PRIORITY') == null) {
      priorityDB.createInitialRoutineData();
      priorityDB.updatePriorityDatabase();
    } else {
      priorityDB.loadPriorityData();
    }

    if (_EDUTASKER.get("ROUTINE") == null) {
      routineDB.createInitialRoutineData();
      routineDB.updateRoutineDataBase();
    } else {
      routineDB.loadRoutineData();
    }
    super.initState();
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
            onPressed: () {
              context.push("/setting");
            })
      ],
      title: Center(child:  Text("Summary", style: H5,)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 48, color: Colors.white),
        onPressed: () => {Navigator.pop(context)},
      ),
      backgroundColor: Color.fromARGB(255, 24, 28, 75),
    );
  }

  Widget getBody() {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        menu(),
        display_piority(),
        display_routine()
      ],
    );
  }

  Widget menu() {
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

  List<dynamic> getPriorityListBy(String priority) {
    return priorityDB.priority
        .where((element) => element.priority == priority)
        .toList();
  }

  Widget display_piority() {
    double w = 150;
    double h = 150;
    double opacity = 0.5;
    EdgeInsets margin = const EdgeInsets.all(5);
    BoxDecoration roundedBoxAmber = BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.amber.withOpacity(opacity));
    BoxDecoration roundedBoxRed = BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.redAccent.withOpacity(opacity));
    BoxDecoration roundedBoxPurple = BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.purpleAccent.withOpacity(opacity));
    BoxDecoration roundedBoxGreen = BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.greenAccent.withOpacity(opacity));
    List<String> priority_list = [
      "Imporntant & urgent",
      "not Imporntant & urgent",
      "Imporntant & not urgent",
      "not Imporntant & not urgent"
    ];
    List<dynamic> Imporntant_Urgent_list = getPriorityListBy(priority_list[0]);
    List<dynamic> NotImporntant_Urgent_list =
        getPriorityListBy(priority_list[1]);
    List<dynamic> Imporntant_NotUrgent_list =
        getPriorityListBy(priority_list[2]);
    List<dynamic> NotImporntant_NotUrgent_list =
        getPriorityListBy(priority_list[3]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.only(left: 18),
          child: const Text(
            "Priority",
            style: H5,
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                decoration: roundedBoxAmber,
                width: w,
                height: h,
                margin: margin,
                // color: Colors.amber,
                child: ListView.builder(
                  itemCount: Imporntant_Urgent_list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(Imporntant_Urgent_list[index].taskname,
                        style: subtitle),
                  ),
                ),
              ),
              Container(
                decoration: roundedBoxRed,
                width: w,
                height: h,
                margin: margin,
                // color: Colors.redAccent,
                child: ListView.builder(
                  itemCount: NotImporntant_Urgent_list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(NotImporntant_Urgent_list[index].taskname,
                        style: subtitle),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                decoration: roundedBoxPurple,
                width: w,
                height: h,
                margin: margin,
                // color: Colors.purpleAccent,
                child: ListView.builder(
                  itemCount: Imporntant_NotUrgent_list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(Imporntant_NotUrgent_list[index].taskname,
                        style: subtitle),
                  ),
                ),
              ),
              Container(
                decoration: roundedBoxGreen,
                width: w,
                height: h,
                margin: margin,
                // color: Colors.greenAccent,
                child: ListView.builder(
                  itemCount: NotImporntant_NotUrgent_list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(NotImporntant_NotUrgent_list[index].taskname,
                        style: subtitle),
                  ),
                ),
              )
            ],
          )
        ],
      )
    ]);
  }

  List<dynamic> getRoutineList() {
    return routineDB.routines;
  }

  Widget display_routine() {
    List<dynamic> rountine_list = getRoutineList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.only(left: 18),
          child: const Text(
            "Routine",
            style: H5,
          )),
      Center(
          child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: primaryColor.withOpacity(0.8)),
              child: ListView.builder(
                  itemCount: rountine_list.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(
                          rountine_list[index].name,
                          style: subtitle,
                        ),
                      trailing: Text('${rountine_list[index].count} ${rountine_list[index].unit}', style: subtitle,) ,))))
    ]);
  }
}
