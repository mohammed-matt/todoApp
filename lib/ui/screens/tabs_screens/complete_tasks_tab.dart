import 'package:flutter/material.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';
import 'package:todo_sqlite_provider/ui/widgets/task_item.dart';
import 'package:provider/provider.dart';

class CompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, value, child) {
        List<Task> completeTasks = value.completeTasks;
        return ListView.builder(
          itemCount: completeTasks.length,
          itemBuilder: (context, index) {
            return TaskItem(completeTasks[index]);
          },
        );
      },
    );
  }
}
