import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'priority_model.g.dart';
@HiveType(typeId: 1, adapterName: "PriorityAdapter")
class PriorityModel {
  @HiveField(0)
  String priority;
  @HiveField(1)
  DateTime? date;
  @HiveField(2)
  String taskname;
  @HiveField(3)
  String description;

  bool more_detail = false;

  PriorityModel(
      {required this.priority,
      required this.date,
      required this.taskname,
      required this.description});

  factory PriorityModel.fromJson(Map<String, dynamic> json) => PriorityModel(priority: json['priority'], date: json['date'], taskname: json['taskname'], description: json['description']);

  Map<String, dynamic> toJson() => {
    'priority': priority,
    'date':date.toString(),
    'description':description,
    'taskname': taskname,

  };
}

class PriorityDatabase {
  List<dynamic> priority = [];
  final _EDUTASKER = Hive.box('EDUTASKER');
  void createInitialRoutineData() {
    priority.add(PriorityModel(priority: "Imporntant & urgent", date: DateTime.now(), taskname: "Test SW", description: "Test Priority"));
  }

  String priorityToJson(List<dynamic> priority) => json.encode(List<dynamic>.from(priority.map((obj) => obj.toJson())));
  List<PriorityModel> priorityFromJson(String str) => List<PriorityModel>.from(json.decode(str).map((e) => PriorityModel.fromJson(e)));

  void loadPriorityData() {
    List<dynamic> priorityData = _EDUTASKER.get('PRIORITY');
    if (priorityData != null) {
      priority = priorityData;
    }
  }

  void updatePriorityDatabase() {
    _EDUTASKER.put('PRIORITY', priority);
  }

  void resetPriorityDatabase() {
    _EDUTASKER.delete('PRIORITY');
  }
}