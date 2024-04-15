// Please rename your function
import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:edu_tasker_app/models/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

// void main(List<String> args) {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: "Flutter App",
//     home:
//         RoutinePage(), //error The error you’re encountering is due to the absence of MaterialLocalization
//     //Floating Button under MaterialApp
//   ));
// }

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  // get routine model
  final _EDUTASKER = Hive.box('EDUTASKER');
  RoutineDatabase routineDB = RoutineDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Dev tool Testing Reset Database !!!
    //routineDB.resetRoutineDataBase();

    if (_EDUTASKER.get("ROUTINE") == null) {
      routineDB.createInitialRoutineData();
      routineDB.updateRoutineDataBase();
      //print("${routineDB.routines}");
    } else {
      // there already exists data
      routineDB.loadRoutineData();
      //print("${routineDB.routines}");
    }
  }


  void increaseCount(int index) {
    setState(() {
      routineDB.routines[index].count = routineDB.routines[index].count + 1;
      print('${routineDB.routines[index].count}');
    });
    routineDB.updateRoutineDataBase();
  }

  void decreaseCount(int index) {
    setState(() {
      if (routineDB.routines[index].count > 0) {
        routineDB.routines[index].count = routineDB.routines[index].count - 1;
      }
    });
    routineDB.updateRoutineDataBase();
  }

  void deleteRoutine(int index) {
    setState(() {
      routineDB.routines.removeAt(index);
    });
    routineDB.updateRoutineDataBase();
  }

  void addRoutine(String name, String description, int count, String unit) {
    setState(() {
      routineDB.routines.add(RoutineModel(
          userId:"test", name: name, description: description, count: count, unit: unit));
    });
    routineDB.updateRoutineDataBase();
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
                Text('คุณต้องการลบ Routine นี้หรือไม่?'),
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
                deleteRoutine(
                    index); // เรียกฟังก์ชัน deleteRoutine เมื่อผู้ใช้กดตกลง
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAddRoutineDialog(BuildContext context) async {
    String name = '';
    int count = 0;
    String unit = '';
    String description = '';

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
                  decoration: InputDecoration(labelText: 'ชื่อ Routine'),
                ),
                TextField(
                  onChanged: (value) => count = int.tryParse(value) ?? 0,
                  decoration: InputDecoration(labelText: 'จำนวน Routine'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  onChanged: (value) => unit = value,
                  decoration: InputDecoration(labelText: 'หน่วย Routine'),
                ),
                TextField(
                  onChanged: (value) => description = value,
                  decoration: InputDecoration(labelText: 'รายละเอียด Routine'),
                ),
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
                addRoutine(name, description, count, unit);
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
            // Text("This is home page",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
            SearchBox(),
            // routine section
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(right: 28, left: 28),
              // color: Colors.red,
              height: 450,
              child: getListViewRoutine(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showAddRoutineDialog(
                  context); // เรียกฟังก์ชันเพื่อแสดง dialog เพิ่ม Routine
            });
          },
          child: Icon(Icons.note_add, color: Colors.white, size: 36,),
          shape: CircleBorder(),
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }

  ListView getListViewRoutine() {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: routineDB.routines.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            textColor: Colors.white,
            tileColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20), // กำหนด border radius เป็น 20
            ),
            //subtitle: Text(routines[index].description),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Remove counter Button
                ElevatedButton(
                  onPressed: () {
                    // code when button is pressed
                    decreaseCount(index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets
                        .zero, // เปลี่ยนเป็น EdgeInsets.zero เพื่อไม่ให้มีพื้นที่ว่างรอบปุ่ม
                    minimumSize: Size(48, 48), // กำหนดขนาดปุ่มเป็น 48x48
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // Routine Infomation Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          routineDB.routines[index].name,
                          style: TextStyle(fontSize: 14),
                        ), //Show Name of Routine
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${routineDB.routines[index].count.toString()}/${routineDB.routines[index].unit}',
                            style: TextStyle(
                                fontSize:
                                    14)), //Show Counting and unit of Routine
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(routineDB.routines[index].description,
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
                //Add Counting Button
                ElevatedButton(
                  onPressed: () {
                    // code when button is pressed
                    increaseCount(index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets
                        .zero, // เปลี่ยนเป็น EdgeInsets.zero เพื่อไม่ให้มีพื้นที่ว่างรอบปุ่ม
                    minimumSize: Size(48, 48), // กำหนดขนาดปุ่มเป็น 48x48
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.redAccent),
              onTap: () => showDeleteConfirmationDialog(context, index),
              ),
            onTap: () {
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 24,
            ));
  }

  AppBar getAppBar() {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 40.0),
            onPressed: () {
              context.push("/setting");
            }),
      ],
      centerTitle: true,
      title: Center(
        child: Text(
          "Routine",
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

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // to set margin
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search taskname',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
