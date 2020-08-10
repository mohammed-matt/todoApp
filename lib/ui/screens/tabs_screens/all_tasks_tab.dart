import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';
import 'package:todo_sqlite_provider/ui/widgets/task_item.dart';

class AllTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, value, child) {
        List<Task> allTasks = value.allTasks;
        return ListView.builder(
          itemCount: allTasks.length,
          itemBuilder: (context, index) {
            return TaskItem(allTasks[index]);
          },
        );
      },
    );
  }
}
