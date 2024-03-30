class RoutineModel {
  String name;
  String description;
  int count;
  String unit;

  RoutineModel(
    {required this.name, required this.description, required this.count, required this.unit}
  );

  static List<RoutineModel> getRoutines() {
    List<RoutineModel> routines = [];
    routines.add(RoutineModel(name: 'Exercise', description: '30 min', count: 1, unit: 'time'));
    routines.add(RoutineModel(name: 'Read Book', description: '1 chapter', count: 0, unit: 'time'));
    routines.add(RoutineModel(name: 'Exercise', description: '10 min', count: 2, unit: 'time'));

    return routines;
  }
}