import 'package:flutter/material.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/repositories/db_repository.dart';

class DbProvider extends ChangeNotifier {
  List<Task> allTasks = [];
  List<Task> completeTasks = [];
  List<Task> notCompleteTasks = [];

  Future<List<Task>> setAllList() async {
    List<Task> tasks = await DbRepository.dbRepository.getAllTask();
    this.allTasks = tasks;
    this.completeTasks = await DbRepository.dbRepository.getComleteTasks();
    this.notCompleteTasks = await DbRepository.dbRepository.notComleteTasks();
    notifyListeners();
    return tasks;
  }

  insertNewTask(Task task) async {
    await DbRepository.dbRepository.insertNewTask(task);
    setAllList();
  }

  updateTask(Task task) async {
    await DbRepository.dbRepository.updateTask(task);
    setAllList();
  }

  deleteTask(Task task) async {
    await DbRepository.dbRepository.deleteTask(task);
    setAllList();
  }

  deleteAllTask() async {
    await DbRepository.dbRepository.deleteAllTasks();
    setAllList();
  }
}
