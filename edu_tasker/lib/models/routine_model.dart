import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'routine_model.g.dart'; // This is required for Hive TypeAdapter generation

@HiveType(typeId: 0) // Specify a unique typeId for Hive
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
  factory RoutineModel.fromJson(Map<dynamic, dynamic> json) => RoutineModel( //bug Map<String, dynamic>
        userId: json['userId'],
        name: json['name'],
        description: json['description'],
        count: json['count'],
        unit: json['unit'],
      );

  // Method for converting a RoutineModel instance to a map
  Map<dynamic, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'description': description,
        'count': count,
        'unit': unit,
      };

  
}

class RoutineDatabase {
  List<RoutineModel> routines = [];

  final _EDUTASKER = Hive.box('EDUTASKER');

  void createInitialRoutineData() {
    routines.add(RoutineModel(userId: "test",name: 'Exercise', description: '30 min', count: 1, unit: 'time'));
    routines.add(RoutineModel(userId: "test",name: 'Read Book', description: '1 chapter', count: 0, unit: 'time'));
    routines.add(RoutineModel(userId: "test",name: 'Exercise', description: '10 min', count: 2, unit: 'time'));
  }

  void loadRoutineData() {
  var routineData = _EDUTASKER.get("ROUTINE");
  if (routineData != null) {
    print(routineData);
    routines = List<RoutineModel>.from(routineData.map((routine) => RoutineModel.fromJson(routine)));
    }
  }

  void updateRoutineDataBase() {
    _EDUTASKER.put("ROUTINE", routines.map((routine) => routine.toJson()).toList());
  }


}