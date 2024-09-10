import 'package:flutter/material.dart';
import 'package:sqlite/util/db_helper.dart';

import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DBHelper();
  List<Todo> _todoList = [];
  var _count = 0;

  _getData() => dbHelper.initializeDB().then((result) {
        dbHelper.getTodos().then((result) {
          setState(() {
            _count = result.length;
            _todoList = result.map(Todo.fromMap).toList();
          });
        });
      });

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("SQLite"),
        ),
        body: ListView.builder(
          itemBuilder: (_, position) => ListItem(todo: _todoList[position]),
          itemCount: _count,
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      );
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.todo});

  final Todo todo;

  Color _getColor() {
    switch (todo.priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getColor(),
            child: Text(todo.priority.toString()),
          ),
          title: Text(todo.title),
          subtitle: Text(todo.date),
          onTap: () => debugPrint("Tapped on ${todo.title}"),
        ),
      );
}
