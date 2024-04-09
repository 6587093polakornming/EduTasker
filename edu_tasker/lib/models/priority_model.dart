class Task {
  String priority = "";
  DateTime? date;
  String taskname = "";
  String description = "";
  bool more_detail = false;

  Task(
      {required this.priority,
      required this.date,
      required this.taskname,
      required this.description});
}