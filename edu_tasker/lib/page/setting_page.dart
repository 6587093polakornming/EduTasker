import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../constants/materialDesign.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String nameUser;
  final _EDUTASKER = Hive.box('EDUTASKER');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameUser = _EDUTASKER.get("NAMEUSER");
  }

  Future<void> showEditDialog(BuildContext context) async {
    String name = nameUser;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ไม่ให้ปิด dialog โดยการแตะภายนอก
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('แก้ไขชื่อ User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(labelText: 'ชื่อ User'),
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
              onPressed: () async {
                // เพิ่ม Routine โดยเรียกฟังก์ชันที่กำหนดไว้ที่บรรทัดที่ 3 โดยส่งพารามิเตอร์ข้อมูลของ Routine
                await _EDUTASKER.put("NAMEUSER",name);
                Navigator.of(context).pop(); // ปิด dialog
                setState(() {
                   nameUser = _EDUTASKER.get("NAMEUSER");
                });
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
          appBar: AppBar(
            centerTitle: true,
            title: Center(
              child: Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize: 34),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 24, 28, 75),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                //TODO BUG edit nameuser
                context.pop();
                // context.push("/home");
              },
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 40.0),
                  onPressed: () {
                    context.push("/home");
                  })
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/default_avatar.png'),
                  radius: 100,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 244,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white ,
                      ),
                      child: Center(child: Text(
                        nameUser, 
                        style: TextStyle(fontSize: 20),)),
                    ),
                    SizedBox(width: 4,),
                    IconButton.filled(
                      onPressed: (){
                        //CODE HERE
                        setState(() {
                          showEditDialog(context);
                        });
                      }, 
                      icon: Icon(Icons.edit, color: Colors.white, size: 30,)
                      ),
                  ],
                ),
                SizedBox(height: 20,),
                //Backup section
                // Code HERE
                Container(
                      width:320,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: primaryColor,
                      ),
                      child: getBackUpSection(),
                ),
                SizedBox(height: 20,),
                //Download section
                //Code HERE
                Container(
                      width:320,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: primaryColor,
                      ),
                      child: getDownloadSection(),
                ),
                SizedBox(height: 20,),
                // Logout Section
                //Code Here
                Container(
                      width:320,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: primaryColor,
                      ),
                      child: getLogoutSection(),
                ),
              ],
            ),
          )),
    );
  }

  GestureDetector getLogoutSection() {
    return GestureDetector(
                  onTap:() {
                    //CODE HERE 
                    FirebaseAuth.instance.signOut().then((value) {
                      context.go('/');}).onError((error, stackTrace) =>  showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("Something wrong"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child : Row(
                      children: [
                        Icon(Icons.logout, size: 48, color: Colors.red,),
                        SizedBox(width: 16,),
                        Text("Logout", style: TextStyle(fontSize: 20, color: Colors.white),)
                      ],
                      )
                  ),
                );
  }

  GestureDetector getDownloadSection() {
    return GestureDetector(
                    onTap:() {
                      //CODE HERE 
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child : Row(
                        children: [
                          Icon(Icons.download, size: 48, color: Colors.blue,),
                          SizedBox(width: 16,),
                          Text("Download Data", style: TextStyle(fontSize: 20, color: Colors.white),)
                        ],
                        )
                    ),
                  );
  }

  GestureDetector getBackUpSection() {
    return GestureDetector(
                      onTap:() {
                        //CODE HERE 
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child : Row(
                          children: [
                            Icon(Icons.backup, size: 48, color: Colors.green,),
                            SizedBox(width: 16,),
                            Text("Backup Data", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                          )
                      ),
                    );
  }
}
