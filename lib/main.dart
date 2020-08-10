import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite_provider/providers/db_provider.dart';
import 'package:todo_sqlite_provider/ui/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbProvider>(
      create: (context) {
        return DbProvider();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MainScreen(),
      ),
    );
  }
}
