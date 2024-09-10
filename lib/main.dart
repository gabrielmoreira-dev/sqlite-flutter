import 'package:flutter/material.dart';
import 'package:sqlite/util/db_helper.dart';
import 'package:sqlite/view/home_page.dart';

import 'model/todo.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  _createRegisters() {
    final dbHelper = DBHelper();
    final today = DateTime.now().toString();
    var todo = Todo(
      title: 'Buy apples',
      priority: 1,
      date: today,
      description: "Fuji",
    );
    dbHelper.insertTodo(todo).then((value) => debugPrint("$value"));
    todo = Todo(
      title: 'Buy oranges',
      priority: 2,
      date: today,
      description: "Pera",
    );
    dbHelper.insertTodo(todo).then((value) => debugPrint("$value"));
    todo = Todo(
      title: 'Travel',
      priority: 3,
      date: today,
      description: "Rio",
    );
    dbHelper.insertTodo(todo).then((value) => debugPrint("$value"));
  }

  @override
  Widget build(BuildContext context) {
    //_createRegisters();
    return const MaterialApp(
      title: "SQLite",
      home: HomePage(),
    );
  }
}
