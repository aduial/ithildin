import 'dart:core';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ithildin/screen/related_card.dart';
import 'package:ithildin/screen/see_card.dart';
import 'package:ithildin/screen/variation_card.dart';

import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/entry_doc.dart';
import '../model/lexicon_change.dart';
import '../model/lexicon_cognate.dart';
import '../model/lexicon_combine.dart';
import '../model/lexicon_element.dart';
import '../model/lexicon_example.dart';
import '../model/lexicon_header.dart';
import '../model/lexicon_gloss.dart';
import '../model/lexicon_inflection.dart';
import '../model/lexicon_see.dart';
import '../model/lexicon_variation.dart';
import '../model/lexicon_related.dart';
import '../model/simplexicon.dart';
import 'change_card.dart';
import 'cognate_card.dart';
import 'combination_card.dart';
import 'element_card.dart';
import 'example_card.dart';
import 'gloss_card.dart';
import 'package:expandable/expandable.dart';

import 'header_card.dart';
import 'inflection_card.dart';
import 'note_card.dart';

Route _anotherDetailRoute(int entryId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        EntryScreen(entryId),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class EntryScreen extends StatefulWidget {
  const EntryScreen(this.entryId, {Key? key}) : super(key: key);
  final int entryId;

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEntryLoading = true;
  bool isHeaderLoading = true;
  bool areGlossesLoading = true;
  bool areVariationsLoading = true;
  bool areCognatesLoading = true;
  bool areRelationsLoading = true;
  bool areInflectionsLoading = true;
  bool areChangesLoading = true;
  bool areCombinationsLoading = true;
  bool areElementsLoading = true;
  bool areExamplesLoading = true;
  bool areSightsLoading = true;
  bool areDocsLoading = true;

  bool cognatesVisible = false;

  late Simplexicon entry;
  late LexiconHeader header;
  late List<LexiconGloss> lexiconGlosses;
  late List<LexiconCognate> lexiconCognates;
  late List<LexiconRelated> lexiconRelated;
  late List<LexiconVariation> lexiconVariations;
  late List<LexiconInflection> lexiconInflections;
  late List<LexiconChange> lexiconChanges;
  late List<LexiconCombine> lexiconCombinations;
  late List<LexiconElement> lexiconElements;
  late List<LexiconExample> lexiconExamples;
  late List<LexiconSee> lexiconSights;
  late List<EntryDoc> entryDocs;
  late List<Simplexicon> otherEntries;

  void initState() {
    super.initState();
    getData();
    setState(() {});
  }

  Future getData() async {
    await loadEntry();
    await loadHeader();
    await loadLexiconGlosses();
    await loadLexiconCognates();
    await loadLexiconRelations();
    await loadLexiconVariations();
    await loadLexiconInflections();
    await loadLexiconChanges();
    await loadLexiconCombinations();
    await loadLexiconElements();
    await loadLexiconExamples();
    await loadLexiconSights();
    await loadEntryDocs();
  }

  Future loadEntry() async {
    setState(() => isEntryLoading = true);
    List<Simplexicon> entryList =
        await EldamoDb.instance.loadSimplexicon(widget.entryId);
    entry = entryList[0];
    setState(() => isEntryLoading = false);
  }

  Future loadHeader() async {
    setState(() => isHeaderLoading = true);
    List<LexiconHeader> headerList =
        await EldamoDb.instance.loadLexiconHeader(widget.entryId);
    if (headerList.isNotEmpty) {
      header = headerList[0];
    }
    setState(() => isHeaderLoading = false);
  }

  Future loadLexiconGlosses() async {
    setState(() => areGlossesLoading = true);
    lexiconGlosses = await EldamoDb.instance.loadLexiconGlosses(widget.entryId);
    setState(() => areGlossesLoading = false);
  }

  Future loadLexiconCognates() async {
    setState(() => areCognatesLoading = true);
    lexiconCognates =
        await EldamoDb.instance.loadLexiconCognates(widget.entryId);
    setState(() => areCognatesLoading = false);
  }

  Future loadLexiconRelations() async {
    setState(() => areRelationsLoading = true);
    lexiconRelated =
        await EldamoDb.instance.loadLexiconRelations(widget.entryId);
    setState(() => areRelationsLoading = false);
  }

  Future loadLexiconVariations() async {
    setState(() => areVariationsLoading = true);
    lexiconVariations =
        await EldamoDb.instance.loadLexiconVariations(widget.entryId);
    setState(() => areVariationsLoading = false);
  }

  Future loadLexiconInflections() async {
    setState(() => areInflectionsLoading = true);
    lexiconInflections =
        await EldamoDb.instance.loadLexiconInflections(widget.entryId);
    setState(() => areInflectionsLoading = false);
  }

  Future loadLexiconChanges() async {
    setState(() => areChangesLoading = true);
    lexiconChanges = await EldamoDb.instance.loadLexiconChanges(widget.entryId);
    setState(() => areChangesLoading = false);
  }

  Future loadLexiconCombinations() async {
    setState(() => areCombinationsLoading = true);
    lexiconCombinations =
        await EldamoDb.instance.loadLexiconCombinations(widget.entryId);
    setState(() => areCombinationsLoading = false);
  }

  Future loadLexiconElements() async {
    setState(() => areElementsLoading = true);
    lexiconElements =
        await EldamoDb.instance.loadLexiconElements(widget.entryId);
    setState(() => areElementsLoading = false);
  }

  Future loadLexiconExamples() async {
    setState(() => areExamplesLoading = true);
    lexiconExamples =
        await EldamoDb.instance.loadLexiconExamples(widget.entryId);
    setState(() => areExamplesLoading = false);
  }

  Future loadLexiconSights() async {
    setState(() => areSightsLoading = true);
    lexiconSights = await EldamoDb.instance.loadLexiconSights(widget.entryId);
    setState(() => areSightsLoading = false);
  }

  Future loadEntryDocs() async {
    setState(() => areDocsLoading = true);
    entryDocs = await EldamoDb.instance.loadEntryDocs(widget.entryId);
    setState(() => areDocsLoading = false);
  }

  _openLinkedEntry(String link) async {
    final langForm = link.split('@');
    otherEntries = await EldamoDb.instance
        .findSimplexiconByLangForm(langForm[0], langForm[1]);
    setState(() {
      Navigator.of(context).push(_anotherDetailRoute(otherEntries[0].id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: OffWhite,
      appBar: AppBar(
        backgroundColor: BlueGrey,
        title: AutoSizeText(
          isEntryLoading ? "Loading..." : entry.form,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w300, color: Laurelin),
          minFontSize: 20,
          stepGranularity: 2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: //isDataLoading
          //? Text("loading ...")
          //:
          ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.yellow,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            isHeaderLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : HeaderCard(header, entry.form, entry.createdBy),
            areGlossesLoading
                ? const LinearProgressIndicator(
                    minHeight: 1,
                    color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : lexiconGlosses.isNotEmpty
                    ? GlossCard(lexiconGlosses)
                    : Container(),
            areVariationsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(Ithildin))
                : lexiconVariations.isNotEmpty
                    ? VariationCard(lexiconVariations)
                    : Container(),
            areInflectionsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : lexiconInflections.isNotEmpty
                    ? InflectionCard(lexiconInflections)
                    : Container(),
            areCognatesLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(Ithildin))
                : lexiconCognates.isNotEmpty
                    ? CognateCard(lexiconCognates)
                    : Container(),
            areRelationsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : lexiconRelated.isNotEmpty
                    ? RelatedCard(lexiconRelated)
                    : Container(),
            areChangesLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(Ithildin))
                : lexiconChanges.isNotEmpty
                    ? ChangeCard(lexiconChanges)
                    : Container(),
            areCombinationsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : lexiconCombinations.isNotEmpty
                    ? CombinationCard(lexiconCombinations)
                    : Container(),
            areElementsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(Ithildin))
                : lexiconElements.isNotEmpty
                    ? ElementCard(lexiconElements)
                    : Container(),
            areExamplesLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : lexiconExamples.isNotEmpty
                    ? ExampleCard(lexiconExamples)
                    : Container(),
            areSightsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(Ithildin))
                : lexiconSights.isNotEmpty
                    ? SeeCard(lexiconSights)
                    : Container(),
            areDocsLoading
                ? const LinearProgressIndicator(
                minHeight: 1,
                color: NotepaperWhite,
                valueColor: AlwaysStoppedAnimation(BlueGrey))
                : entryDocs.isNotEmpty
                    ? NoteCard(entryDocs, _openLinkedEntry)
                    : Container(),
          ],
        ),
      ),
    );
  }
}
