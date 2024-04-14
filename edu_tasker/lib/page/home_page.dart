import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:edu_tasker_app/widgets/widgetHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// void main(List<String> args) {
//   runApp(const HomePage());
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            //TODO Section 1 Weather Report and DateTime
            Container(
              margin: EdgeInsets.only(left: 18),
              width: 360,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: primaryColor,
                border: Border.all(color: Colors.black,width: 2.0,),
              ),
            ),
            SizedBox(
              height: 8,
            ),

            //Title Your Task
            Container(
                margin: EdgeInsets.only(left: 18), child: Text("Your Task", style: H5,)),

            //TODO section 2 make ListView summary at home page
            Container(
              height: 216,
              // color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  getWidgetListViewHomePage(Container()),
                  SizedBox(
                    width: 16,
                  ),
                  getWidgetListViewHomePage(Container()),
                  SizedBox(
                    width: 16,
                  ),
                  getWidgetListViewHomePage(Container()),
                  SizedBox(
                    width: 16,
                  ),
                  getWidgetListViewHomePage(Container()),
                ],
              ),
            ),

            //Title Content
            Container(
                margin: EdgeInsets.only(left: 18), child: Text("Content", style: H5)),
            SizedBox(
              height: 8,
            ),

            //TODO section 4 Navigation Button
            //context.push("/routine");
            Container(
              margin: EdgeInsets.only(left: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      //TODO use GestureDetector onTap for Navigation -> getWidgetButtonHomePage
                      getWidgetButtonHomePage(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note_alt, size: 40.0, color: Colors.white,),
                            SizedBox(height: 4,),
                            Text('Priority Task', style: subtitle,)
                          ],
                        )
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/routine");
                        },
                        child: getWidgetButtonHomePage(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.update, size: 40.0, color: Colors.white,),
                              SizedBox(height: 4,),
                              Text('Routine', style: subtitle,)
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {context.push("/classSchedule");},
                        child: getWidgetButtonHomePage(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.view_week, size: 40.0, color: Colors.white,),
                              SizedBox(height: 4,),
                              Text('Class Schedule', style: subtitle,)
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      getWidgetButtonHomePage(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.summarize, size: 40.0, color: Colors.white,),
                            SizedBox(height: 4,),
                            Text('Summary', style: subtitle,)
                          ],
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
      centerTitle: true,
      title: Container(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            "Name",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 8.00, bottom: 8.00, top: 10.00),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          // Picture User
          backgroundImage: AssetImage(
            'assets/default_avatar.png',
          ),
          radius: 200.0,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 28, 75),
    );
  }
}
