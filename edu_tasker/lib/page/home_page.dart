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
            end:Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 55, 29, 100), Color.fromARGB(255,20, 47, 114)],
            )
         ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: getAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4,),
              //TODO Section 1 Weather Report and DateTime
              Container(
                margin: EdgeInsets.only(left:18),
                width: 360,
                height: 160,
                color: Colors.red,
              ),
              SizedBox(height: 8,),

              //Title Your Task
              Container(margin: EdgeInsets.only(left: 18),
              child: Text("Your Task")
              ),
              
              //TODO section 2 make ListView summary at home page
              Container(
                height: 216,
                // color: Colors.red,
                child: ListView(
                   scrollDirection: Axis.horizontal,
                   padding: const EdgeInsets.all(8),
                   children: <Widget>[
                    Container(
                      width: 160, height: 208, color: Colors.red,
                    ), SizedBox(width: 16,),
                    Container(
                       width: 160, height: 208,  color: Colors.red
                    ), SizedBox(width: 16,),
                    Container(
                         width: 160, height: 208,  color: Colors.red
                    ), SizedBox(width: 16,),
                    Container(
                      width: 160, height: 208,  color: Colors.red
                    ),
                   ],
                ),
              ),
              
              //Title Content
              Container(margin: EdgeInsets.only(left: 18),
              child: Text("Content")
              ),
              SizedBox(height: 8,),

              //TODO section 4 Navigation Button
              //context.push("/routine");
              Container(
                margin: EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                      Container(width: 160, height: 104, color: Colors.red,),
                       SizedBox(width: 16,),
                      Container(width: 160, height: 104, color: Colors.red),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(children: [
                      Container(width: 160, height: 104, color: Colors.red,),
                      SizedBox(width: 16,),
                      Container(width: 160, height: 104, color: Colors.red),
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
            margin:EdgeInsets.only(left: 8.00, bottom: 8.00, top: 10.00),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              // Picture User
              backgroundImage: AssetImage('assets/default_avatar.png',),
              radius: 200.0,
              ),
          ),
          backgroundColor: Color.fromARGB(255, 24, 28, 75),
        );
  }
}