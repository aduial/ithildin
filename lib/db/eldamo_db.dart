import 'package:flutter/services.dart';
import 'package:ithildin/model/entry_doc.dart';
import 'package:ithildin/model/lexicon_cognate.dart';
import 'package:ithildin/model/lexicon_gloss.dart';
import 'package:ithildin/model/lexicon_header.dart';
import 'package:ithildin/model/lexicon_related.dart';
import 'package:ithildin/model/lexicon_variation.dart';
import 'package:ithildin/model/lexicon_inflection.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ithildin/model/language.dart';
import 'package:ithildin/model/simplexicon.dart';
import 'package:ithildin/config/config.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class EldamoDb {
  static final EldamoDb instance = EldamoDb._init();
  static Database? _database;

  String langCatWhere = "< 2";

  void setLangCatWhere(String whereClause){
    langCatWhere = whereClause;
    loadEldarinLanguages();
  }

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
  }



  // ID = 1 = All Eldarin languages
  Future<List<Language>> loadEldarinLanguages() async {
    final db = await instance.database;
    // const orderBy = "${LanguageFields.id} ASC";
    const orderBy = "${LanguageFields.listOrder} ASC";
    final result = await db.rawQuery(
        "SELECT * FROM $languageTable WHERE CATEGORY $langCatWhere ORDER BY $orderBy");
    return result.map((json) => Language.fromJson(json)).toList();
  }

  // Active modern language have parent_id = 10 (inactive have 11)
  Future<List<Language>> loadModernLanguages() async {
    final db = await instance.database;
    const orderBy = "${LanguageFields.id} ASC";
    final result = await db.rawQuery("select * from $languageTable "
        "WHERE PARENT_ID = 10 "
        "ORDER BY $orderBy");
    return result.map((json) => Language.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> loadSimplexicons() async {
    final db = await instance.database;
    const orderBy = "${SimplexiconFields.id} ASC";
    final result = await db.rawQuery("SELECT * FROM $simplexiconView "
        "ORDER BY $orderBy "
        "LIMIT 30");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> loadSimplexicon(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $simplexiconView "
        "WHERE ID = $entryId");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<LexiconHeader>> loadLexiconHeader(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconHeaderView "
        "WHERE entry_id = $entryId");
    return result.map((json) => LexiconHeader.fromJson(json)).toList();
  }

  Future<List<LexiconGloss>> loadLexiconGlosses(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconGlossView "
        "WHERE ${LexiconGlossFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => LexiconGloss.fromJson(json)).toList();
  }

  Future<List<LexiconCognate>> loadLexiconCognates(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconCognateView "
        "WHERE ${LexiconCognateFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => LexiconCognate.fromJson(json)).toList();
  }

  Future<List<LexiconRelated>> loadLexiconRelated(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconRelatedView "
        "WHERE ${LexiconRelatedFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => LexiconRelated.fromJson(json)).toList();
  }

  Future<List<LexiconVariation>> loadLexiconVariation(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconVariationView "
        "WHERE ${LexiconVariationFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => LexiconVariation.fromJson(json)).toList();
  }

  Future<List<LexiconInflection>> loadLexiconInflection(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconInflectionView "
        "WHERE ${LexiconInflectionFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => LexiconInflection.fromJson(json)).toList();
  }

  Future<List<EntryDoc>> loadEntryDocs(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $entryDocView "
        "WHERE ${EntryDocFields.entryId} = $entryId "
        "LIMIT 30");
    return result.map((json) => EntryDoc.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> findSimplexiconByLangForm(String langAbbr, String form) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $simplexiconView "
        "WHERE ${SimplexiconFields.formLangAbbr} = '$langAbbr' "
        "AND ${SimplexiconFields.form} = '$form' "
        "LIMIT 1");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<bool> existsSimplexiconById(int id) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $simplexiconView "
        "WHERE ${SimplexiconFields.id} = $id "
        "LIMIT 1");
    return result.isNotEmpty;
  }

  Future<bool> existsSimplexiconByLangForm(String langAbbr, String form) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $simplexiconView "
        "WHERE ${SimplexiconFields.formLangAbbr} = '$langAbbr' "
        "AND ${SimplexiconFields.form} = '$form' "
        "LIMIT 1");
    return result.isNotEmpty;
  }

  String formLangWhereClause(int formLangId) {
    if (formLangId == allLanguages) {
      return SimplexiconFields.formLangId + " LIKE '%'";
    } else if (formLangId == quenyaInclNeo) {
      return "(" + SimplexiconFields.formLangId + " = " +
          neoQuenya.toString() + " OR " +
          SimplexiconFields.formLangId + " = " +
          quenya.toString() + ")";
    } else if (formLangId == sindarinIncNeo) {
      return "(" + SimplexiconFields.formLangId + " = " +
          neoSindarin.toString() + " OR " +
          SimplexiconFields.formLangId + " = " +
          sindarin.toString() + ")";
    } else if (formLangId == pElvishInclNeo) {
      return "(" + SimplexiconFields.formLangId + " = " +
          neoPElvish.toString() + " OR " +
          SimplexiconFields.formLangId + " = " +
          pElvish.toString() + ")";
    } else {
      return SimplexiconFields.formLangId + " = " + formLangId.toString();
    }
  }

  Future<List<Simplexicon>> simplexiconFormFilter(
      String formFilter, int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = "${SimplexiconFields.nform} ASC";
    String glossLang = "= ${glossLangId.toString()}";
    String whereFormLangId = formLangWhereClause(formLangId);
    String whereGlossLangId = "${SimplexiconFields.glossLangId} $glossLang";
    String whereFormLike = "${SimplexiconFields.nform} LIKE '%$formFilter%'";
    final result = await db.rawQuery("SELECT * from $simplexiconView "
        "WHERE $whereFormLangId "
        "AND $whereGlossLangId "
        "AND $whereFormLike "
        "ORDER BY $orderBy");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> simplexiconGlossFilter(
      String glossFilter, int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = "${SimplexiconFields.id} ASC";
    String glossLang = "= ${glossLangId.toString()}";
    String whereFormLangId = formLangWhereClause(formLangId);
    String whereGlossLangId = "${SimplexiconFields.glossLangId} $glossLang";
    String whereGlossLike = "${SimplexiconFields.gloss} LIKE '%$glossFilter%'";
    final result = await db.rawQuery("SELECT * from $simplexiconView "
        "WHERE $whereFormLangId "
        "AND $whereGlossLangId "
        "AND $whereGlossLike "
        "ORDER BY $orderBy");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
