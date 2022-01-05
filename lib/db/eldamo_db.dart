import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ithildin/model/language.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class EldamoDb {
  static final EldamoDb instance = EldamoDb._init();
  static Database? _database;

  EldamoDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('eldamo.sqlite');
    return _database!;
  }

  // return database if already available in App directory
  // else, copy from assets folder to app directory
  Future<Database> _initDB(String dbName) async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, dbName);
    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(dbPath, version: 1);

    // final dbPath = await getDatabasesPath();
    // final path = join(dbPath, filePath);
    // return await openDatabase(path, version: 1);
  }

  Future<List<Language>> loadLanguages() async {
    final db = await instance.database;
    final orderBy = '${LanguageFields.id} ASC';
    final result = await db.rawQuery('select * from $tableLanguages '
        'where PARENT_ID is not null '
        'and MNEMONIC is not null '
        'and ID < 1000 '
        'ORDER BY $orderBy');
    return result.map((json) => Language.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
