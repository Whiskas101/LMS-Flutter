import 'dart:convert';

import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/utils/helpers.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Recents.dart';

class DatabaseService{
  //Singleton approach

  static Database? _db;


  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();


  final String _recentsTable = "recents";
  final String _recentsId = "link_code";
  final String _recentsTime = "last_opened";
  final String _recentsMaterial = "material";
  final String _recentsSubject = "subject";

  Future<Database> get database async {
    if(_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }



  Future<Database> getDatabase() async {

    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, "main1_db.db");

    print("Opening db");
    final database = await openDatabase(
        databasePath,
      onCreate: (db, version){
          db.execute(
              """
                CREATE TABLE IF NOT EXISTS $_recentsTable (
                  $_recentsId INT PRIMARY KEY,
                  $_recentsMaterial TEXT NOT NULL,
                  $_recentsTime INT NOT NULL,
                  $_recentsSubject TEXT NOT NULL
                );
              """
          );
      },
      version: 4
    );

    return database;

  }

  Future<void> addRecent(CourseMaterial material, String subject) async {
    String linkCode = codeExtractor(material.link);
    String recentMaterialDataJsonString = jsonEncode(material.toJSON());
    final db = await database;
    await db.insert(
        _recentsTable,
        {
          _recentsId: linkCode,
          _recentsTime: DateTime.now().microsecondsSinceEpoch.toInt(), // sqflite doesn't support DateTime, hence this conversion is necessary
          _recentsMaterial: recentMaterialDataJsonString,
          _recentsSubject: subject
        },
      conflictAlgorithm: ConflictAlgorithm.replace
      );
    print("Inserted ${material.name}");
  }

  Future<List<Recent>> getRecent(int num) async {
    final db = await database;
    final data = await db.query(
      _recentsTable,
      orderBy: '$_recentsTime DESC',
      limit: num
    );

    print("raw fetched data $data");

    final value =  data.map(
        (row){
          final raw = row['material'] as String;
          final subject = row['subject'] as String;
          print(subject);
          print(raw);
          return Recent(CourseMaterial.fromJSON(jsonDecode(raw)), subject);
        }
    ).toList();

    print("Recent Encoded: $value");
    return value;

  }

  // void delete() async {
  //   final db = await database;
  //   print(await DatabaseService.instance.getDatabase());
  //   final data = await db.rawQuery("SELECT * FROM $_recentsTable");
  //   print(data);
  // }


}