import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import '../model/todo.dart';

class DBHelper {
  final todoTable = "todo";
  final idField = "id";
  final titleField = "title";
  final descriptionField = "description";
  final priorityField = "priority";
  final dateField = "date";

  static final _dbHelper = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  factory DBHelper() => _dbHelper;

  Future<Database> get db async {
    _db ??= await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}todos.db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int newVersion) async => await db.execute(
        """CREATE TABLE $todoTable(
          $idField INTEGER PRIMARY KEY,
          $titleField TEXT,
          $descriptionField TEXT,
          $priorityField INTEGER,
          $dateField TEXT
        )""",
      );

  Future<int> insertTodo(Todo todo) async {
    final db = await this.db;
    return await db.insert(todoTable, todo.toMap());
  }

  Future<List> getTodos() async {
    final db = await this.db;
    return await db
        .rawQuery("SELECT * FROM $todoTable ORDER BY $priorityField ASC");
  }

  Future<int> getCount() async {
    final db = await this.db;
    return Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM $todoTable"),
    )!;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await this.db;
    return await db.update(
      todoTable,
      todo.toMap(),
      where: "$idField = ?",
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await this.db;
    return await db.rawDelete("DELETE FROM $todoTable WHERE $idField = $id");
  }
}
