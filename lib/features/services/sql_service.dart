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

  /*Future<Database> initializeDatabase() async {
    if (db != null) {
      return db!;
    }

    String databasePath = await getDatabasesPath();

    String path = join(databasePath, databaseName);

    const String todoTableQuery = '''
      CREATE TABLE todos(
        id TEXT PRIMARY KEY,
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
    final database = await initializeDatabase();
    return database.insert(
      'todos',
      {
        'id': todo.id,
        'title': todo.title,
        'description': todo.description,
        'createdAt': todo.createdAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModel>> getTodos() async {
    final database = await initializeDatabase();
    final List<Map<String, Object?>> result = await database.query(
      'todos',
      orderBy: 'createdAt DESC',
    );
    return result.map(_fromMap).toList();
  }

  Future<int> updateTodo(TodoModel todo) async {
    final database = await initializeDatabase();
    return database.update(
      'todos',
      {
        'title': todo.title,
        'description': todo.description,
        'createdAt': todo.createdAt?.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(String id) async {
    final database = await initializeDatabase();
    return database.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTodos() async {
    final database = await initializeDatabase();
    await database.delete('todos');
  }

  TodoModel _fromMap(Map<String, Object?> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String?,
      description: map['description'] as String?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.parse(map['createdAt'] as String),
    );
  }*/

  /*Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();

    String path = join(databasePath, databaseName);

    String questionsQuery =
        'CREATE TABLE ${TableName.questionTable.tableName}(questionId INTEGER PRIMARY KEY AUTOINCREMENT,quizId INTEGER NOT NULL,'
        'question TEXT NOT NULL,answer TEXT NOT NULL,selectedAnswer TEXT NOT NULL,mode TEXT NOT NULL)';

    String quizQuery =
        'CREATE TABLE ${TableName.quizTable.tableName}(quizId INTEGER PRIMARY KEY AUTOINCREMENT,time TEXT NOT NULL)';

    return await openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(questionsQuery);
        await database.execute(quizQuery);
      },
      version: 1,
    );
  }*/

  /*///CREATE quiz
  Future<int> addQuiz(QuizModel quizModel) async {
    final db = await SqlService.helper.initializeDatabase();
    var isInsertedCounter = await db.insert(TableName.quizTable.tableName, quizModel.toMap());
    return isInsertedCounter;
  }

  ///READ quiz
  Future<List<QuizModel>> getQuiz() async {
    final db = await SqlService.helper.initializeDatabase();
    final List<Map<String, Object?>> resultQuery = await db.query(TableName.quizTable.tableName);
    return resultQuery.map((e) => QuizModel.fromMap(e)).toList();
  }

  ///DELETE quiz
  Future<void> deleteQuizTable() async {
    final db = await SqlService.helper.initializeDatabase();
    await db.delete(TableName.quizTable.tableName);
  }

  Future<void> dropQuizTable() async {
    final db = await SqlService.helper.initializeDatabase();
    await db.execute("DROP TABLE ${TableName.quizTable.tableName}");
  }

  ///CREATE question
  Future<void> addQuestions(QuestionModal questionModal) async {
    final db = await SqlService.helper.initializeDatabase();
    var isInsertedCounter =
        await db.insert(TableName.questionTable.tableName, questionModal.toMap());
    Log.success("Quiz inserted====>$isInsertedCounter");
  }

  ///READ question
  Future<List<QuestionModal>> getQuestions() async {
    final db = await SqlService.helper.initializeDatabase();
    final List<Map<String, Object?>> resultQuery =
        await db.query(TableName.questionTable.tableName);
    return resultQuery.map((e) => QuestionModal.fromMap(e)).toList();
  }

  ///READ HISTORY
  Future<List<JoinedModel>> getHistory() async {
    final db = await SqlService.helper.initializeDatabase();
    final String sqlQuery = '''
        SELECT qz.time,qz.quizId,qt.questionId,qt.question,qt.answer,qt.selectedAnswer,qt.mode
        FROM ${TableName.quizTable.tableName} AS qz INNER JOIN ${TableName.questionTable.tableName} AS qt ON
        qz.quizId=qt.quizId
    ''';
    final List<Map<String, Object?>> resultQuery = await db.rawQuery(sqlQuery);
    return resultQuery.map((e) => JoinedModel.fromMap(e)).toList();
  }*/
}
