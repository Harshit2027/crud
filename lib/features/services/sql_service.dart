import 'package:crud/features/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlService {
  static SqlService helper = SqlService._();

  SqlService._();

  String databaseName = 'todo.db';

  Database? db;

  Future<Database> initializeDatabase() async {
    if (db != null) {
      return db!;
    }

    String databasePath = await getDatabasesPath();

    String path = join(databasePath, databaseName);

    const String todoTableQuery = '''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        createdAt TEXT
      )
    ''';

    db = await openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(todoTableQuery);
      },
      version: 1,
    );

    return db!;
  }

  Future<int> addTodo(TodoModel todo) async {
    final database = await SqlService.helper.initializeDatabase();
    var isInsertedCounter = await database.insert('todos', todo.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return isInsertedCounter;
  }

  Future<List<TodoModel>> getTodos() async {
    final database = await SqlService.helper.initializeDatabase();
    final List<Map<String, Object?>> resultQuery = await database.query('todos');
    return resultQuery.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<int> updateTodo(TodoModel todo) async {
    final database = await SqlService.helper.initializeDatabase();
    var isInsertedCounter = await database.update('todos', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);

    return isInsertedCounter;
  }

  Future<int> deleteTodo(int id) async {
    final database = await SqlService.helper.initializeDatabase();
    return database.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

}
