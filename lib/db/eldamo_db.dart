import 'dart:async';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ithildin/model/entry_doc.dart';
import 'package:ithildin/model/lexicon_change.dart';
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

import '../config/user_preferences.dart';
import '../model/lexicon_combine.dart';
import '../model/lexicon_element.dart';
import '../model/lexicon_example.dart';
import '../model/lexicon_see.dart';
import '../model/nothrim.dart';

class EldamoDb {

  List<Simplexicon> regexBufferList = <Simplexicon>[];

  static final EldamoDb instance = EldamoDb._init();
  static Database? _database;

  EldamoDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('eldamo.sqlite');
    return _database!;
  }

  void clearRegexBufferList(){
    regexBufferList.clear();
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

  // get single language
  Future<Language> loadLanguage(int languageId) async {
    final db = await instance.database;
    final result = await db.rawQuery(
        "SELECT * FROM $languageTable WHERE ID = $languageId");
    return result.map((json) => Language.fromJson(json)).first;
  }

  // filtered language sets
  Future<List<Language>> loadEldarinLanguageSet() async {
    int langCat = (UserPreferences.getLanguageSet() ?? defaultLanguageSetIndex) + 1;
    String langCatWhere = '< $langCat';
    final db = await instance.database;
    // const orderBy = "${LanguageFields.id} ASC";
    const orderBy = "${LanguageFields.listOrder} ASC";
    final result = await db.rawQuery(
        "SELECT * FROM $languageTable WHERE CATEGORY $langCatWhere ORDER BY $orderBy");
    return result.map((json) => Language.fromJson(json)).toList();
  }

  // Active glosslanguages have parent_id = 10 (inactive have 11)
  Future<List<Language>> loadGlossLanguageSet() async {
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
        "LIMIT 100");
    return result.map((json) => LexiconGloss.fromJson(json)).toList();
  }

  Future<List<LexiconCognate>> loadLexiconCognates(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconCognateView "
        "WHERE ${LexiconCognateFields.entryId} = $entryId "
        "LIMIT 100");
    return result.map((json) => LexiconCognate.fromJson(json)).toList();
  }

  Future<List<LexiconRelated>> loadLexiconRelations(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconRelatedView "
        "WHERE ${LexiconRelatedFields.entryId} = $entryId "
        "LIMIT 100");
    return result.map((json) => LexiconRelated.fromJson(json)).toList();
  }

  Future<List<LexiconVariation>> loadLexiconVariations(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconVariationView "
        "WHERE ${LexiconVariationFields.entryId} = $entryId "
        "LIMIT 100");
    return result.map((json) => LexiconVariation.fromJson(json)).toList();
  }

  Future<List<LexiconInflection>> loadLexiconInflections(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconInflectionView "
        "WHERE ${LexiconInflectionFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconInflection.fromJson(json)).toList();
  }

  Future<List<LexiconChange>> loadLexiconChanges(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconChangeView "
        "WHERE ${LexiconChangeFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconChange.fromJson(json)).toList();
  }

  Future<List<LexiconCombine>> loadLexiconCombinations(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconCombineView "
        "WHERE ${LexiconCombineFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconCombine.fromJson(json)).toList();
  }

  Future<List<LexiconElement>> loadLexiconElements(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconElementView "
        "WHERE ${LexiconElementFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconElement.fromJson(json)).toList();
  }

  Future<List<LexiconExample>> loadLexiconExamples(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconExampleView "
        "WHERE ${LexiconExampleFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconExample.fromJson(json)).toList();
  }

  Future<List<LexiconSee>> loadLexiconSights(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $lexiconSeeView "
        "WHERE ${LexiconSeeFields.entryId} = $entryId "
        "LIMIT 1000");
    return result.map((json) => LexiconSee.fromJson(json)).toList();
  }

  Future<List<EntryDoc>> loadEntryDocs(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM $entryDocView "
        "WHERE ${EntryDocFields.entryId} = $entryId "
        "LIMIT 100");
    return result.map((json) => EntryDoc.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> findSimplexiconByLangForm(
      String langAbbr, String form) async {
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
      return "(" +
          SimplexiconFields.formLangId +
          " = " +
          neoQuenya.toString() +
          " OR " +
          SimplexiconFields.formLangId +
          " = " +
          quenya.toString() +
          ")";
    } else if (formLangId == sindarinIncNeo) {
      return "(" +
          SimplexiconFields.formLangId +
          " = " +
          neoSindarin.toString() +
          " OR " +
          SimplexiconFields.formLangId +
          " = " +
          sindarin.toString() +
          ")";
    } else if (formLangId == pElvishInclNeo) {
      return "(" +
          SimplexiconFields.formLangId +
          " = " +
          neoPElvish.toString() +
          " OR " +
          SimplexiconFields.formLangId +
          " = " +
          pElvish.toString() +
          ")";
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
    String matchFormFilter = applyMatchMethod(formFilter);
    String whereFormLike = "${SimplexiconFields.nform} LIKE '$matchFormFilter'";
    print (whereFormLike);
    final result = await db.rawQuery("SELECT * from $simplexiconView "
        "WHERE $whereFormLangId "
        "AND $whereGlossLangId "
        "AND $whereFormLike "
        "ORDER BY $orderBy");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> simplexiconFormRegexFilter(
      String regex, int formLangId, int glossLangId) async {
    if (regexBufferList.isEmpty || (regexBufferList[0].formLangId != (UserPreferences.getActiveEldarinLangId() ?? defaultEldarinLangId))) {
      print("refresh buffer");
      await refreshRegexBufferList(formLangId, glossLangId);
    }
    List<Simplexicon> regexFilteredList = List.from(regexBufferList);
    RegExp regExp = RegExp(r'(' + regex.toLowerCase() + ')');
    //RegExp regExp = RegExp(r"(ad.+d$)");
    regexFilteredList.retainWhere((slex) => regExp.hasMatch(slex.nform));
    return regexFilteredList;
  }

  Future<List<Simplexicon>> simplexiconGlossFilter(
      String glossFilter, int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = "${SimplexiconFields.nform} ASC";
    String glossLang = "= ${glossLangId.toString()}";
    String whereFormLangId = formLangWhereClause(formLangId);
    String whereGlossLangId = "${SimplexiconFields.glossLangId} $glossLang";
    String matchGlossFilter = applyMatchMethod(glossFilter);
    String whereGlossLike = "${SimplexiconFields.gloss} LIKE '$matchGlossFilter'";
    final result = await db.rawQuery("SELECT * from $simplexiconView "
        "WHERE $whereFormLangId "
        "AND $whereGlossLangId "
        "AND $whereGlossLike "
        "ORDER BY $orderBy");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  Future<List<Simplexicon>> simplexiconGlossRegexFilter(
      String regex, int formLangId, int glossLangId) async {
    if (regexBufferList.isEmpty || (regexBufferList[0].glossLangId != (UserPreferences.getActiveGlossLangId() ?? defaultGlossLangId))) {
      print("refresh buffer");
      await refreshRegexBufferList(formLangId, glossLangId);
    }
    List<Simplexicon> regexFilteredList = List.from(regexBufferList);
    RegExp regExp = RegExp("r" + regex);
    regexFilteredList.retainWhere((slex) => regExp.hasMatch(slex.gloss));
    return regexFilteredList;
  }

  Future<void> refreshRegexBufferList(int formLangId, int glossLangId) async {
    final db = await instance.database;
    const orderBy = "${SimplexiconFields.nform} ASC";
    String glossLang = "= ${glossLangId.toString()}";
    String whereFormLangId = formLangWhereClause(formLangId);
    String whereGlossLangId = "${SimplexiconFields.glossLangId} $glossLang";
    final result = await db.rawQuery("SELECT * from $simplexiconView "
        "WHERE $whereFormLangId "
        "AND $whereGlossLangId "
        "ORDER BY $orderBy");
    regexBufferList = result.map((json) => Simplexicon.fromJson(json)).toList();
  }

  String applyMatchMethod(String likeClause){
    switch(UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex) {
      case 1: {  return '$likeClause%'; }
      break;

      case 2: {  return '%$likeClause'; }
      break;

      case 3: {  return '$likeClause'; }
      break;

      default: { return '%$likeClause%'; }
      break;
    }
  }

  // returns a list of all Entry and Word entries in a root Entry,
  // given any of its child ID's
  Future<List<Nothrim>> nothrim(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("WITH RECURSIVE nothrim(m) AS ( "
        "SELECT $entryId "
        "UNION "
        "SELECT e1.ID FROM ENTRY e1 "
        "JOIN nothrim ON e1.PARENT_ID = m "
        "UNION "
        "SELECT e2.PARENT_ID FROM ENTRY e2 "
        "JOIN nothrim ON e2.ID = m "
        ") "
        "SELECT n.m FROM nothrim n "
        "JOIN ENTRY e ON n.m = e.ID "
        "WHERE n.m IS NOT NULL "
        "AND e.ENTRY_TYPE_ID IN (100, 120) "
        "ORDER BY n.m ASC "
        "LIMIT 100;");
    return result.map((json) => Nothrim.fromJson(json)).toList();
  }

  // returns all Entry and Word entries in a root Entry,
  // given any of its child ID's
  Future<List<Simplexicon>> nothrimLexicon(int entryId) async {
    final db = await instance.database;
    final result = await db.rawQuery("WITH RECURSIVE nothrim(m) AS ( "
        "SELECT $entryId "
        "UNION "
        "SELECT e1.ID FROM ENTRY e1 "
        "JOIN nothrim ON e1.PARENT_ID = m "
        "UNION "
        "SELECT e2.PARENT_ID FROM ENTRY e2 "
        "JOIN nothrim ON e2.ID = m "
        ") "
        "SELECT s.* FROM nothrim n "
        "JOIN simplexicon s ON n.m = s.ID "
        "WHERE n.m IS NOT NULL "
        "ORDER BY n.m ASC "
        "LIMIT 100;");
    return result.map((json) => Simplexicon.fromJson(json)).toList();
  }

}
