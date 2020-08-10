import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite_provider/models/task.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';
import 'package:todo_sqlite_provider/ui/screens/tabs_screens/all_tasks_tab.dart';
import 'package:todo_sqlite_provider/ui/screens/tabs_screens/complete_tasks_tab.dart';
import 'package:todo_sqlite_provider/ui/screens/tabs_screens/notcomplete_tasks_tab.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String description;
  setTitle(String value) {
    this.title = value;
  }

  setDescription(String value) {
    this.description = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DbProvider>(context, listen: false).insertNewTask(Task(
          title: this.title,
        ));
        Navigator.pop(context);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Todo Tasks'),
            bottom: TabBar(
              tabs: [
                Tab(child: Text('All Tasks')),
                Tab(child: Text('Complete Tasks')),
                Tab(child: Text('Not Complete Tasks')),
              ],
            ),
          ),
          body: Consumer<DbProvider>(
            builder: (context, value, child) {
              Future<List<Task>> allTasks = value.setAllList();
              return TabBarView(children: [
                AllTasksTab(),
                CompleteTasksTab(),
                NotCompleteTasksTap()
              ]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Form(
                        key: formKey,
                        child: CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              onPressed: () {},
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: TextFormField(
                                  validator: (value) {
                                    // ignore: missing_return
                                    if (value.isEmpty) {
                                      return 'text title is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onSaved: (value) {
                                    setTitle(value);
                                  },
                                ),
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                submitTask(context);
                              },
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: TextFormField(
                                  validator: (value) {
                                    // ignore: missing_return
                                    if (value.isEmpty) {
                                      return 'text description is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onSaved: (value) {
                                    setDescription(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              submitTask(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('Submit'),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  context: context);
            },
          )),
    );
  }
}
