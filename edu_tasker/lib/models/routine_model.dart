import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'routine_model.g.dart'; // This is required for Hive TypeAdapter generation

@HiveType(typeId: 0, adapterName: "RoutineAdapter") // Specify a unique typeId for Hive
class RoutineModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  int count;
  @HiveField(4)
  String unit;

  RoutineModel({required this.userId, required this.name, required this.description, required this.count, required this.unit});


  // Factory constructor for creating a new RoutineModel instance from a map
  factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel( //bug Map<String, dynamic>
        userId: json['userId'],
        name: json['name'],
        description: json['description'],
        count: json['count'],
        unit: json['unit'],
      );

  
  // Method for converting a RoutineModel instance to a map
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'description': description,
        'count': count,
        'unit': unit,
      };

  
}

class RoutineDatabase {
  List<dynamic> routines = [];
  final _EDUTASKER = Hive.box('EDUTASKER');
  void createInitialRoutineData() {
    routines.add(RoutineModel(userId: "test",name: 'Exercise', description: '30 min', count: 1, unit: 'time'));
    routines.add(RoutineModel(userId: "test",name: 'Read Book', description: '1 chapter', count: 0, unit: 'time'));
    routines.add(RoutineModel(userId: "test",name: 'Exercise', description: '10 min', count: 2, unit: 'time'));
  }

  String routineToJson(List<dynamic> routines) => json.encode(List<dynamic>.from(routines.map((routine) => routine.toJson())));

  List<RoutineModel> routineFromJson(String str) => List<RoutineModel>.from(json.decode(str).map((x) => RoutineModel.fromJson(x)));

  void loadRoutineData() {
    //assign to List<dynamic> first
    List<dynamic> routineData = _EDUTASKER.get("ROUTINE");
    print('RunTime Routine Data ${routineData.runtimeType}');
    print('Routine Data ${routineData}');
    if (routineData != null) {
      print(routines.runtimeType);
      routines = routineData;
      }
    // String resultToJson = routineToJson(routines);
    // print('resultTOJson ${resultToJson}');
    // var resultJson = routineFromJson(resultToJson);
    // print(resultJson.runtimeType);
    // print('resultFROMJson ${resultJson}');

  }

  void updateRoutineDataBase() {
    // routines.map((routine) => routine.toJson()).toList();
    // var update = routines.map((routine) => routine.toJson()).toList();
    print('update ${routines.runtimeType}');
    print(routines);
    _EDUTASKER.put("ROUTINE", routines);
    //_EDUTASKER.put("ROUTINE", routines.toList());
    
  }

  void resetRoutineDataBase(){
    _EDUTASKER.delete("ROUTINE");
  }

}