import 'package:edu_tasker_app/models/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(const RoutinePage());
}

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  // get routine model
  List<RoutineModel> routines = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routines = RoutineModel.getRoutines();
  }

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
          body: Column(
            children: [
              // Text("This is home page",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
              SearchBox(),
              // routine section
              SizedBox(height: 32),
              Container(
                // color: Colors.red,
                height: 450,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: routines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: Colors.white,
                      subtitle: Text(routines[index].description),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(routines[index].name),
                          Text('${routines[index].count.toString()}/${routines[index].unit}'),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(), 
          
                ),
              ),
            ],
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
          title: Center(
            child: Text("Routine", 
            style: TextStyle(color: Colors.white, fontSize: 34),
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
