import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/repositories/db_task.dart';

class DbRepository {
  DbRepository._();
  static final DbRepository dbRepository = DbRepository._();

  insertNewTask(Task task) async {
    await DbTask.dbTask.insertNewTask(task.toJson());
  }

  Future<List<Task>> getAllTask() async {
    List<Map<String, dynamic>> result = await DbTask.dbTask.getAllTasks();
    List<Task> allTasks = result.map((e) => Task.fromJson(e)).toList();
    //await Future.delayed(Duration(seconds: 2));
    return allTasks;
  }

  Future<List<Task>> getComleteTasks() async {
    List<Map<String, dynamic>> result = await DbTask.dbTask.getCompleteTasks();
    List<Task> completeTasks = result.map((e) => Task.fromJson(e)).toList();
    return completeTasks;
  }

  Future<List<Task>> notComleteTasks() async {
    List<Map<String, dynamic>> result =
        await DbTask.dbTask.getNotCompleteTasks();
    List<Task> notCompleteTasks = result.map((e) => Task.fromJson(e)).toList();
    return notCompleteTasks;
  }

  Future<int> updateTask(Task task) async {
    task.toggleTask();
    int result = await DbTask.dbTask.updateTask(task.toJson(), task.id);
    return result;
  }

  Future<int> deleteTask(Task task) async {
    int result = await DbTask.dbTask.deleteTask(task.id);
    return result;
  }

  deleteAllTasks() async {
    await DbTask.dbTask.deleteAllTasks();
  }
}
