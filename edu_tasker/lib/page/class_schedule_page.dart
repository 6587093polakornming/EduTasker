import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:edu_tasker_app/models/class_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClassSchedulePage extends StatefulWidget {
  const ClassSchedulePage({super.key});

  @override
  State<ClassSchedulePage> createState() => _ClassSchedulePageState();
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  final _EDUTASKER = Hive.box('EDUTASKER');
  ClassDatabase classDB = ClassDatabase();
  late int selectDayOfWeek;
  int? nowDayOfWeek;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectDayOfWeek = 1;
    nowDayOfWeek = DateTime.now().weekday;
    //Dev tool Testing Reset Database !!!
    // classDB.resetRoutineDataBase(1);
    // classDB.resetRoutineDataBase(2);
    // classDB.resetRoutineDataBase(3);
    // classDB.resetRoutineDataBase(4);
    // classDB.resetRoutineDataBase(5);
    // classDB.resetRoutineDataBase(6);
    // classDB.resetRoutineDataBase(7);

    if (_EDUTASKER
            .get(ClassDatabase.mappingIntegerToDatabase(selectDayOfWeek)) ==
        null) {
      print('null create and now day is : ${selectDayOfWeek}');
      classDB.createInitialClassData();
      //classDB.updateClassDataBase(selectDayOfWeek);
      classDB.loadClassData(selectDayOfWeek);
    } else {
      print('select and now day is : ${selectDayOfWeek}');
      classDB.loadClassData(selectDayOfWeek);
    }


  }

  String TimeOfDayToString(int hour, int minute) {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }

  void checkBoxChange(bool? value, int index) {
    print(
        "checkBoxChange from ${classDB.classSchedules[index].check} to ${!classDB.classSchedules[index].check}");
    setState(() {
      classDB.classSchedules[index].check =
          !classDB.classSchedules[index].check;
    });
    
    classDB.updateClassDataBase(selectDayOfWeek);
  }

  void deleteClass(int index) {
    setState(() {
      classDB.classSchedules.removeAt(index);
    });
    print("Delete Update");
    classDB.updateClassDataBase(selectDayOfWeek);
  }

  void addClass(
      String name, TimeOfDay startTime, TimeOfDay endTime, int AddDayOfWeek,
      {bool checkClass = false}) {
    setState(() {
      classDB.classSchedules.add(ClassModel(
          userId: "test",
          className: name,
          startTime: startTime,
          endTime: endTime,
          check: checkClass,
          dayOfWeek: AddDayOfWeek));
    });
    print("Add Update");
    classDB.updateClassDataBase(selectDayOfWeek);
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
                Text('คุณต้องการลบ Class นี้หรือไม่?'),
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
                deleteClass(
                    index); // เรียกฟังก์ชัน deleteRoutine เมื่อผู้ใช้กดตกลง
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAddClassDialog(BuildContext context) async {
    String name = '';
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ไม่ให้ปิด dialog โดยการแตะภายนอก
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เพิ่ม Routine'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(labelText: 'ชื่อ Class'),
                ),
                //2 start Time
                Row(
                  children: [
                    Text("StartTime: "),
                    ElevatedButton(
                      onPressed: () async {
                        // Show time picker and wait for user input
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: startTime,
                        );
                        // Update startTime if user has selected a time
                        if (selectedTime != null) {
                          setState(() {
                            startTime = selectedTime;
                          });
                        }
                      },
                      child: Text('Select Time'),
                    ),
                  ],
                ),

                //3 end Time
                Row(
                  children: [
                    Text("End Time:"),
                    ElevatedButton(
                      onPressed: () async {
                        // Show time picker and wait for user input
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: endTime,
                        );
                        // Update startTime if user has selected a time
                        if (selectedTime != null) {
                          setState(() {
                            endTime = selectedTime;
                          });
                        }
                      },
                      child: Text('Select Time'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Day of Week: ${ClassDatabase.mappingIntegerToDatabase(selectDayOfWeek)}'), // Show selected day of week
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
                // เพิ่ม Routine โดยเรียกฟังก์ชันที่กำหนดไว้ที่บรรทัดที่ 3 โดยส่งพารามิเตอร์ข้อมูลของ Routine
                addClass(name, startTime, endTime, selectDayOfWeek);
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
          ],
        );
      },
    );
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
        body: Column(
          children: [
            SizedBox(height: 44),
            selectWeekBar(),
            Container(
              margin: EdgeInsets.only(right: 16, left: 16),
              height: 350,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: classDB.classSchedules.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //TODO
                    textColor: Colors.white,
                    tileColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // กำหนด border radius เป็น 20
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(classDB.classSchedules[index].className,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: classDB.classSchedules[index]
                                                  .check !=
                                              null &&
                                          classDB.classSchedules[index].check ==
                                              true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ))),
                        Expanded(
                            //classDB.classSchedules[index].startTime
                            child: Text(
                                '${TimeOfDayToString(classDB.classSchedules[index].startTime.hour, classDB.classSchedules[index].startTime.minute)}: ${TimeOfDayToString(classDB.classSchedules[index].endTime.hour, classDB.classSchedules[index].endTime.minute)}',
                                style: subtitle)),
                      ],
                    ),
                    //TODO todolist
                    leading: GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blueAccent,
                        value: classDB.classSchedules[index].check,
                        onChanged: (value) {
                          //TODO
                          checkBoxChange(
                              classDB.classSchedules[index].check, index);
                        },
                      ),
                    ),
                    trailing: GestureDetector(
                      child: Icon(Icons.delete, color: Colors.redAccent),
                      onTap: () {
                        showDeleteConfirmationDialog(context, index);
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showAddClassDialog(
                  context); // เรียกฟังก์ชันเพื่อแสดง dialog เพิ่ม Routine
            });
          },
          child: Icon(
            Icons.note_add,
            color: Colors.white,
            size: 36,
          ),
          shape: CircleBorder(),
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }

  Container selectWeekBar() {
    return Container(
      height: 40,
      width: 390,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        children: <Widget>[
          TabSelectWeek(1, "Monday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(2, "Tuesday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(3, "Wednesday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(4, "Thursday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(5, "Friday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(6, "Saturday"),
          SizedBox(
            width: 4,
          ),
          TabSelectWeek(7, "Sunday"),
          SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }

  ElevatedButton TabSelectWeek(int numberDayOfWeek, String dayName) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
        ),
        onPressed: () {
          classDB.updateClassDataBase(selectDayOfWeek);
          setState(() {
            selectDayOfWeek = numberDayOfWeek;
            print(selectDayOfWeek);
            classDB.loadClassData(selectDayOfWeek);
          });
        },
        child: Text(dayName));
  }

  AppBar getAppBar() {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 40.0),
            onPressed: () {}),
      ],
      centerTitle: true,
      title: Center(
        child: Text(
          "Class Schedule",
          style: TextStyle(color: Colors.white, fontSize: 34),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Color.fromARGB(255, 24, 28, 75),
    );
  }
}
