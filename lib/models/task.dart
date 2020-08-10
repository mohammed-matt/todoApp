import 'package:todo_sqlite_provider/repositories/db_task.dart';

class Task {
  int id;
  String title;
  bool complete;

  Task({this.title, this.complete = false});
  Task.fromJson(Map<String, dynamic> map) {
    this.id = map[DbTask.taskIdColumn];
    this.title = map[DbTask.taskTitleColumn];
    this.complete = map[DbTask.taskIsCompleteColumn] == 1 ? true : false;
  }

  toJson() {
    return {
      DbTask.taskTitleColumn: this.title,
      DbTask.taskIsCompleteColumn: this.complete ? 1 : 0
    };
  }

  toggleTask() {
    this.complete = !this.complete;
  }
}
