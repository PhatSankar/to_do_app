import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  final _boxPref = Hive.box("ToDoAppBox-Sankar");
  void saveToDoList(List toDoList) async {
    _boxPref.put("TODOLIST", toDoList);
  }

  List getToDoList() {
    var tempToDoList = _boxPref.get("TODOLIST");
    tempToDoList ??= [
          ["Tutorial", false],
          ["Hold and drag to reorder item", false],
          ["Swipe left to remove", false],
        ];
    return tempToDoList;
  }
}