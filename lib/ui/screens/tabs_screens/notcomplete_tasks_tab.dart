import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';
import 'package:todo_sqlite_provider/ui/widgets/task_item.dart';

class NotCompleteTasksTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, value, child) {
        List<Task> notCompleteTasks = value.notCompleteTasks;
        return ListView.builder(
          itemCount: notCompleteTasks.length,
          itemBuilder: (context, index) {
            return TaskItem(notCompleteTasks[index]);
          },
        );
      },
    );
  }
}
