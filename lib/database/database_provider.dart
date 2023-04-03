import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _dbName = 'pontos_turisticos.db';
  static const _dbVersion = 1;

  DatabaseProvider._init();

  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;


}