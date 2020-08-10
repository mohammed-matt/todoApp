import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';

class TaskItem extends StatelessWidget {
  Task task;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        leading: IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Colors.redAccent,
          ),
          onPressed: () {
            Provider.of<DbProvider>(context, listen: false).deleteTask(task);
          },
        ),
        trailing: Checkbox(
          value: task.complete,
          onChanged: (value) {
            Provider.of<DbProvider>(context, listen: false).updateTask(task);
          },
        ),
      ),
    );
    // );
  }
}
