import 'package:edu_tasker_app/page/routine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Task {
  String priority = "";
  DateTime? date;
  String taskname = "";
  String description = "";
  bool more_detail = false;

  Task(
      {required this.priority,
      required this.date,
      required this.taskname,
      required this.description});
}

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
  List<Task> Task_List = [];

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
        floatingActionButton: getFloatingButton(),
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
      title: SearchBox_(),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 48, color: Colors.white),
        onPressed: () => {},
      ),
      backgroundColor: Color.fromARGB(255, 24, 28, 75),
    );
  }

  TextField SearchBox_() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: 'Task name',
        prefixIcon: Icon(Icons.search),
        fillColor: Colors.white,
        filled: true,
      ),
      onChanged: (value) => {},
    );
  }

  FloatingActionButton getFloatingButton() {
    return FloatingActionButton(
        onPressed: () => {showAddRoutineDialog(context)},
        child: Icon(
          Icons.note_add,
          color: Colors.white,
          size: 36,
        ),
        backgroundColor: Colors.greenAccent);
  }

  Container getBody() {
    return Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: Task_List.length,
        itemBuilder: (context, index) {
          return ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textColor: Colors.white,
            tileColor: Color.fromARGB(255, 24, 28, 75),
            title: Text(
              Task_List[index].taskname,
            ),
            subtitle: Task_List[index].more_detail == false
                ? Text(Task_List[index].priority)
                : Column(
                    children: [
                      Text(Task_List[index].priority),
                      Text(Task_List[index].description)
                    ],
                  ),
            onTap: () => {tapShowDetail(index)},
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => {showDeleteConfirmationDialog(context, index)},
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 24,
        ),
      ),
    );
  }

  void add_Task(
      String priority, DateTime date, String taskname, String description) {
    setState(() {
      Task_List.add(Task(
          date: date,
          priority: priority,
          taskname: taskname,
          description: description));
    });
  }

  void remove_Task(index) {
    setState(() {
      Task_List.removeAt(index);
    });
  }

  void tapShowDetail(index) {
    setState(() {
      Task_List[index].more_detail = !Task_List[index].more_detail;
    });
  }

  Future<void> showAddRoutineDialog(BuildContext context) async {
    String taskname = '';
    String priority = "Imporntant & urgent";
    DateTime date = DateTime.now();
    String description = '';
    List<String> priority_list = [
      "Imporntant & urgent",
      "not Imporntant & urgent",
      "Imporntant & not urgent",
      "not Imporntant & not urgent"
    ];

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ไม่ให้ปิด dialog โดยการแตะภายนอก
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setStateSB) => AlertDialog(
                  title: Text('เพิ่ม task'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          onChanged: (value) => taskname = value,
                          decoration: InputDecoration(labelText: 'ชื่อ Task'),
                        ),
                        TextField(
                          onChanged: (value) => description = value,
                          decoration:
                              InputDecoration(labelText: 'รายละเอียด Task'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Priority : $priority"),
                            TextButton(
                                child: Text(priority_list[0]),
                                onPressed: () {
                                  setStateSB(
                                    () {
                                      priority = priority_list[0];
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                )),
                            TextButton(
                                child: Text(priority_list[1]),
                                onPressed: () {
                                  setStateSB(
                                    () {
                                      priority = priority_list[1];
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.yellowAccent),
                                )),
                            TextButton(
                                child: Text(
                                  priority_list[2],
                                ),
                                onPressed: () {
                                  setStateSB(
                                    () {
                                      priority = priority_list[2];
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.amberAccent),
                                )),
                            TextButton(
                                child: Text(priority_list[3]),
                                onPressed: () {
                                  setStateSB(
                                    () {
                                      priority = priority_list[3];
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.greenAccent),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('ตกลง'),
                      onPressed: () {
                        // เพิ่ม Routine โดยเรียกฟังก์ชันที่กำหนดไว้ที่บรรทัดที่ 3 โดยส่งพารามิเตอร์ข้อมูลของ Routine
                        add_Task(priority, date, taskname, description);
                        Navigator.of(context).pop(); // ปิด dialog
                      },
                    ),
                    TextButton(
                      child: Text('ยกเลิก'),
                      onPressed: () {
                        // เพิ่ม Routine โดยเรียกฟังก์ชันที่กำหนดไว้ที่บรรทัดที่ 3 โดยส่งพารามิเตอร์ข้อมูลของ Routine
                        Navigator.of(context).pop(); // ปิด dialog
                      },
                    )
                  ],
                ));
      },
    );
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ไม่ให้ปิด dialog โดยการแตะภายนอก
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คุณแน่ใจหรือไม่?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('คุณต้องการลบ Task นี้หรือไม่?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                remove_Task(
                    index); // เรียกฟังก์ชัน deleteRoutine เมื่อผู้ใช้กดตกลง
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
          ],
        );
      },
    );
  }
}
