import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CentralDatabaseHelper {
  static final _dbName = 'centralDatabase.db';
  static final _dbVersion = 1;

  static final tableName_courses = 'courses';
  static final tableName_schedule = 'schedules';
  static final tableName_events = 'events';

  static final id = 'id';
  static final code = 'course_code';
  static final year = 'year';
  static final sem = 'sem';
  static final quarter = 'quarter';
  static final color = 'color';
  static final units = 'units';
  static final qpi = 'qpi';
  static final isIncludedInQPI = 'is_included_in_qpi';
  static final days = 'days';
  static final start = 'start';
  static final end = 'end';
  static final inEnlistment = 'in_enlistment';
  static final professor = 'professor';
  static final notes = 'notes';
  static final name = 'name';
  static final description = 'description';
  static final isTask = 'is_task';
  static final isDone = 'is_done';

  // singleton class
  CentralDatabaseHelper._privateConstructor();
  static final CentralDatabaseHelper instance =
      CentralDatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await _initializeDatabase();
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreateDatabase,
      onUpgrade: (_, __, ___) {},
      onDowngrade: (_, __, ___) {},
    );
  }

  void _onCreateDatabase(Database db, int ver) async {
    await createCoursesTable(db, ver);
    await createSchedulesTable(db, ver);
    await createEventsTable(db, ver);
  }

  Future createCoursesTable(Database db, int ver) async {
    if (db == null) db = await database;

    await (await CentralDatabaseHelper.instance.database)
        .execute('DROP TABLE IF EXISTS $tableName_courses');
        
    await db.execute('''
      CREATE TABLE $tableName_courses(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $code TEXT NOT NULL,
      $year INTEGER NOT NULL,
      $sem INTEGER,
      $color INTEGER,
      $units INTEGER,
      $qpi REAL NOT NULL,
      $isIncludedInQPI INTEGER NOT NULL )
      ''');
  }

  Future createSchedulesTable(Database db, int ver) async {
    if (db == null) db = await database;

    await (await CentralDatabaseHelper.instance.database)
        .execute('DROP TABLE IF EXISTS $tableName_schedule');

    await db.execute('''
      CREATE TABLE $tableName_schedule(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $code TEXT NOT NULL,
      $year INTEGER NOT NULL,
      $sem INTEGER NOT NULL,
      $quarter INTEGER,
      $color INTEGER NOT NULL,
      $days INTEGER NOT NULL,
      $start INTEGER NOT NULL,
      $end INTEGER NOT NULL,
      $inEnlistment INTEGER NOT NULL,
      $professor TEXT,
      $notes TEXT )
    ''');
  }

  Future createEventsTable(Database db, int ver) async {
    if (db == null) db = await database;

    await (await CentralDatabaseHelper.instance.database)
        .execute('DROP TABLE IF EXISTS $tableName_events');

    await db.execute('''
      CREATE TABLE $tableName_events(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $description TEXT,
      $start TEXT,
      $end TEXT,
      $isTask INTEGER,
      $isDone INTEGER )
    ''');
  }
}
