import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbTask {
  DbTask._();
  static final DbTask dbTask = DbTask._();
  static final String taskTabel = 'tasks';
  static final String taskIdColumn = 'taskId';
  static final String taskTitleColumn = 'taskTitle';
  static final String taskIsCompleteColumn = 'taskIsComplete';

  Database database;
  initDb() async {
    if (database != null) {
      return database;
    } else {
      database = await connectDb();
      return database;
    }
  }

  Future<Database> connectDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, 'tasks.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE $taskTabel 
      ($taskIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,
       $taskTitleColumn TEXT NOT NULL,
        $taskIsCompleteColumn INTEGER NOT NULL)''');
      },
    );
    return database;
  }

  Future<int> insertNewTask(Map<String, dynamic> map) async {
    try {
      database = await initDb();
      int rowIndex = await database.insert(taskTabel, map);
      return rowIndex;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    try {
      database = await initDb();
      List<Map<String, dynamic>> listTask = await database.query(taskTabel);
      return listTask;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getCompleteTasks() async {
    try {
      database = await initDb();
      List<Map<String, dynamic>> listTaskComplete = await database
          .query(taskTabel, where: '$taskIsCompleteColumn=?', whereArgs: [1]);
      return listTaskComplete;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getNotCompleteTasks() async {
    try {
      database = await initDb();
      List<Map<String, dynamic>> listTaskNotComplete = await database
          .query(taskTabel, where: '$taskIsCompleteColumn=?', whereArgs: [0]);
      return listTaskNotComplete;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<int> updateTask(Map<String, dynamic> map, int id) async {
    try {
      database = await initDb();
      int rows = await database
          .update(taskTabel, map, where: '$taskIdColumn = ?', whereArgs: [id]);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDb();
      int rows = await database
          .delete(taskTabel, where: '$taskIdColumn=?', whereArgs: [id]);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  deleteAllTasks() async {
    try {
      database = await initDb();
      int rows = await database.delete(taskTabel);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }
}
