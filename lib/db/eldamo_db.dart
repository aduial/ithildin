import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ithildin/model/language.dart';
import 'package:ithildin/model/simplexicon.dart';
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

  Future<List<Language>> loadEldarinLanguages() async {
    final db = await instance.database;
    const orderBy = '${LanguageFields.id} ASC';
    final result = await db.rawQuery('SELECT * FROM $languageTable '
        'WHERE PARENT_ID IS NOT NULL '
        'AND MNEMONIC IS NOT NULL '
        'AND ID < 1000 '
        'ORDER BY $orderBy');
    return result.map((json) => Language.fromJson(json)).toList();
  }

  Future<List<Language>> loadModernLanguages() async {
    final db = await instance.database;
    const orderBy = '${LanguageFields.id} ASC';
    final result = await db.rawQuery('select * from $languageTable '
        'WHERE PARENT_ID IS NOT NULL '
        'AND MNEMONIC IS NOT NULL '
        'AND ID > 1000 '
        'ORDER BY $orderBy');
    return result.map((json) => Language.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> loadSimplexicons() async {
    final db = await instance.database;
    const orderBy = '${SimplexiconFields.entryId} ASC';
    final result = await db.rawQuery('SELECT * FROM $simplexiconTable '
        'ORDER BY $orderBy '
        'LIMIT 30');
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> simplexiconFormFilter(String formFilter, int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = '${SimplexiconFields.entryId} ASC';
    String formLang  = (formLangId == 1) ? "LIKE '%'" : "= ${formLangId.toString()}";
    String glossLang = (glossLangId == 1001) ? "LIKE '%'" : "= ${glossLangId.toString()}";
    String whereFormLangId = '${SimplexiconFields.formLangId} $formLang';
    String whereGlossLangId = '${SimplexiconFields.glossLangId} $glossLang';
    String whereFormLike = "${SimplexiconFields.form} LIKE '%$formFilter%'";
    final result = await db.rawQuery('SELECT * from $simplexiconTable '
        'WHERE $whereFormLangId '
        'AND $whereGlossLangId '
        'AND $whereFormLike '
        'ORDER BY $orderBy');
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> simplexiconGlossFilter(String glossFilter, int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = '${SimplexiconFields.entryId} ASC';
    String formLang  = (formLangId == 1) ? "LIKE '%'" : "= ${formLangId.toString()}";
    String glossLang = (glossLangId == 1001) ? "LIKE '%'" : "= ${glossLangId.toString()}";
    String whereFormLangId = '${SimplexiconFields.formLangId} $formLang';
    String whereGlossLangId = '${SimplexiconFields.glossLangId} $glossLang';
    String whereGlossLike = "${SimplexiconFields.gloss} LIKE '%$glossFilter%'";
    final result = await db.rawQuery('SELECT * from $simplexiconTable '
        'WHERE $whereFormLangId '
        'AND $whereGlossLangId '
        'AND $whereGlossLike '
        'ORDER BY $orderBy');
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
