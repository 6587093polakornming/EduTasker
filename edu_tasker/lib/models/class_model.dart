import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'class_model.g.dart'; // This is required for Hive TypeAdapter generation

@HiveType(typeId: 2, adapterName: "ClassAdapter")

// Note: TimeOfDay Class for time
class ClassModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String className;
  @HiveField(2)
  bool check;
  @HiveField(3)
  TimeOfDay startTime;
  @HiveField(4)
  TimeOfDay endTime;
  @HiveField(5)     // monday = 1 , sunday = 7
  int dayOfWeek;

  ClassModel({required this.userId, required this.className, 
      required this.check, required this.startTime, 
      required this.endTime, required this.dayOfWeek});
}

class ClassDatabase {
  List<dynamic> classSchedules = [];
  final _EDUTASKER = Hive.box('EDUTASKER');

  void createInitialClassData() {
    // TimeOfDay(hour: 15, minute: 0); // 3:00pm
    classSchedules.add(ClassModel(userId: "test", className: "Example", check: false, startTime: TimeOfDay(hour: 8, minute: 30), endTime: TimeOfDay(hour: 10, minute: 30), dayOfWeek: 1));
    print("Create init 1");
    updateClassDataBase(1);
    classSchedules=[];

    classSchedules.add(ClassModel(userId: "test", className: "Example", check: false, startTime: TimeOfDay(hour: 12, minute: 00), endTime: TimeOfDay(hour: 17, minute: 00), dayOfWeek: 2));
    classSchedules.add(ClassModel(userId: "test", className: "Example", check: false, startTime: TimeOfDay(hour: 12, minute: 30), endTime: TimeOfDay(hour: 13, minute: 30), dayOfWeek: 2));
    updateClassDataBase(2);
    classSchedules=[];
  }

  void loadClassData(int numberDayOfWeek){
    print("Load Function Active");
    List<dynamic>? classData = _EDUTASKER.get(mappingIntegerToDatabase(numberDayOfWeek));
    if (classData != null) {
      classSchedules = classData;
    }else{
      classSchedules = [];
    }
  }

  static String mappingIntegerToDatabase(int numberDayOfWeek) {
    switch(numberDayOfWeek){
      case 1: { return "MONDAY";} break; 
      case 2: { return "TUESDAY";} break; 
      case 3: { return "WEDNESDAY";} break; 
      case 4: { return "THURDDAY";} break; 
      case 5: { return "FRIDAY";} break; 
      case 6: { return "SATURDAY";} break; 
      case 7: { return "SUNDAY";} break; 
      default: { 
      //statements;  
        return "SUNDAY";
      }
      break; 
    }
  }

  void updateClassDataBase(int numberDayOfWeek){
    // Sorting the classSchedules list using a custom comparator that utilizes the _timeToInt helper function
    classSchedules.sort((classA, classB) => _timeToInt(classA.startTime).compareTo(_timeToInt(classB.startTime)));
    print('${numberDayOfWeek} FROM sorting ${classSchedules}');
    _EDUTASKER.put(mappingIntegerToDatabase(numberDayOfWeek), classSchedules);

  }

  // Helper function to convert TimeOfDay to a single integer representing minutes since midnight
  int _timeToInt(TimeOfDay time) {
    return time.hour * 60 + time.minute; // Convert time to minutes since midnight
  }

  void resetRoutineDataBase(int numberDayOfWeek){
    _EDUTASKER.delete(mappingIntegerToDatabase(numberDayOfWeek));
  }

}