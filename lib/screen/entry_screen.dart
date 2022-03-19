import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom; // that is
import 'package:ithildin/screen/related_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ithildin/screen/variation_list.dart';

import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/entry_doc.dart';
import '../model/lexicon_cognate.dart';
import '../model/lexicon_header.dart';
import '../model/lexicon_gloss.dart';
import '../model/lexicon_inflection.dart';
import '../model/lexicon_variation.dart';
import '../model/lexicon_related.dart';
import '../model/simplexicon.dart';
import 'cognate_list.dart';
import 'gloss_list.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;

import 'inflection_list.dart';

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
  bool areRelatedLoading = true;
  bool areInflectionsLoading = true;
  bool areDocsLoading = true;

  bool cognatesVisible = false;

  late Simplexicon entry;
  late LexiconHeader header;
  late List<LexiconGloss> lexiconGlosses;
  late List<LexiconCognate> lexiconCognates;
  late List<LexiconRelated> lexiconRelated;
  late List<LexiconVariation> lexiconVariations;
  late List<LexiconInflection> lexiconInflections;
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
    await loadLexiconRelated();
    await loadLexiconVariation();
    await loadLexiconInflection();
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

  Future loadLexiconRelated() async {
    setState(() => areRelatedLoading = true);
    lexiconRelated = await EldamoDb.instance.loadLexiconRelated(widget.entryId);
    setState(() => areRelatedLoading = false);
  }

  Future loadLexiconVariation() async {
    setState(() => areVariationsLoading = true);
    lexiconVariations =
        await EldamoDb.instance.loadLexiconVariation(widget.entryId);
    setState(() => areVariationsLoading = false);
  }

  Future loadLexiconInflection() async {
    setState(() => areInflectionsLoading = true);
    lexiconInflections =
        await EldamoDb.instance.loadLexiconInflection(widget.entryId);
    setState(() => areInflectionsLoading = false);
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
                ? CircularProgressIndicator.adaptive()
                : headerCard(header, entry.form, entry.createdBy),
            areGlossesLoading
                ? CircularProgressIndicator.adaptive()
                : lexiconGlosses.isNotEmpty
                    ? GlossCard(lexiconGlosses)
                    : Container(),
            areVariationsLoading
                ? CircularProgressIndicator.adaptive()
                : lexiconVariations.isNotEmpty
                    ? VariationCard(lexiconVariations)
                    : Container(),
            areInflectionsLoading
                ? CircularProgressIndicator.adaptive()
                : lexiconInflections.isNotEmpty
                    ? InflectionCard(lexiconInflections)
                    : Container(),
            areCognatesLoading
                ? CircularProgressIndicator.adaptive()
                : lexiconCognates.isNotEmpty
                    ? CognateCard(lexiconCognates)
                    : Container(),
            areRelatedLoading
                ? CircularProgressIndicator.adaptive()
                : lexiconRelated.isNotEmpty
                    ? RelatedCard(lexiconRelated)
                    : Container(),
            areDocsLoading
                ? CircularProgressIndicator.adaptive()
                : entryDocs.isNotEmpty
                    ? NotesCard(entryDocs, _openLinkedEntry)
                    : Container(),
          ],
        ),
      ),
    );
  }
}

class headerCard extends StatelessWidget {
  LexiconHeader header;
  String entryForm;
  String? createdBy;

  headerCard(this.header, this.entryForm, this.createdBy);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 4),
            child: Text(entryForm,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: MountainBlue)),
          ),
          (createdBy?.isEmpty ?? true)
              ? Container(height: 0, width: 0)
              : Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                  child: Text('created by: ' + (createdBy ?? ''),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: BlueGrey,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic)),
                ),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 10),
              child: AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: header.language!.toUpperCase() + '.  ',
                      style: const TextStyle(
                          color: ThemeTextColour2, fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: (header.type ?? '') + '  ',
                      style: const TextStyle(
                          color: MountainBlue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: header.gloss != null && header.gloss!.isNotEmpty
                          ? ' "' + (header.gloss ?? '') + '"'
                          : '',
                      style: const TextStyle(
                          color: MiddleGreen, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 20),
                minFontSize: 12,
                stepGranularity: 2,
                maxLines: 2,
              )),
        ]);
  }
}

class GlossCard extends StatelessWidget {
  List<LexiconGloss> lexiconGlosses;

  GlossCard(this.lexiconGlosses);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconGlosses.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GlossListItem(
                  entryId: lexiconGlosses[index].entryId,
                  gloss: lexiconGlosses[index].gloss,
                  reference: lexiconGlosses[index].reference,
                );
              }));
    }

    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: BlueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                // fadeCurve: Curves.decelerate,
                                // animationDuration: const Duration(milliseconds: 400),
                                // scrollAnimationDuration: const Duration(milliseconds: 400),
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: lexiconGlosses.isEmpty
                                  ? Text("no glosses found",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: LightBlueGrey))
                                  : Text(
                                      "gloss" +
                                          (lexiconGlosses.length > 1
                                              ? "es"
                                              : ""),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Laurelin),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: buildList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class VariationCard extends StatelessWidget {
  List<LexiconVariation> lexiconVariations;

  VariationCard(this.lexiconVariations);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconVariations.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return VariationListItem(
                  entryId: lexiconVariations[index].entryId,
                  mark: lexiconVariations[index].mark,
                  lform: lexiconVariations[index].lform,
                  typeId: lexiconVariations[index].typeId,
                  varsource: lexiconVariations[index].varsource,
                );
              }));
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: BlueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            // fadeCurve: Curves.decelerate,
                            // animationDuration: const Duration(milliseconds: 400),
                            // scrollAnimationDuration: const Duration(milliseconds: 400),
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: lexiconVariations.isEmpty
                              ? Text("no variations found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                              : Text(
                                  "variation" +
                                      (lexiconVariations.length > 1 ? "s" : ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CognateCard extends StatelessWidget {
  List<LexiconCognate> lexiconCognates;

  CognateCard(this.lexiconCognates);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconCognates.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CognateListItem(
                  entryId: lexiconCognates[index].entryId,
                  language: lexiconCognates[index].language,
                  form: lexiconCognates[index].form,
                  gloss: lexiconCognates[index].gloss!,
                  sources: lexiconCognates[index].sources,
                  cognateId: lexiconCognates[index].cognateId,
                );
              }));
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: BlueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            // fadeCurve: Curves.decelerate,
                            // animationDuration: const Duration(milliseconds: 400),
                            // scrollAnimationDuration: const Duration(milliseconds: 400),
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: White,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: lexiconCognates.isEmpty
                              ? Text("no cognates found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                              : Text(
                                  "cognate" +
                                      (lexiconCognates.length > 1 ? "s" : ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class InflectionCard extends StatelessWidget {
  List<LexiconInflection> lexiconInflections;

  InflectionCard(this.lexiconInflections);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconInflections.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InflectionListItem(
                  entryId: lexiconInflections[index].entryId,
                  mark: lexiconInflections[index].mark,
                  form: lexiconInflections[index].form,
                  inflections: lexiconInflections[index].inflections,
                  gloss: lexiconInflections[index].gloss,
                  references: lexiconInflections[index].references,
                );
              }));
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: BlueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: lexiconInflections.isEmpty
                              ? Text("no inflections found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                              : Text(
                                  "inflection" +
                                      (lexiconInflections.length > 1
                                          ? "s"
                                          : ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class RelatedCard extends StatelessWidget {
  List<LexiconRelated> lexiconRelated;

  RelatedCard(this.lexiconRelated);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: NotepaperWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: BlueBottom),
              primary: false,
              itemCount: lexiconRelated.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RelatedListItem(
                  entryId: lexiconRelated[index].entryId,
                  languageFrom: lexiconRelated[index].languageFrom,
                  formFrom: lexiconRelated[index].formFrom,
                  glossFrom: lexiconRelated[index].glossFrom,
                  relation: lexiconRelated[index].relation,
                  languageTo: lexiconRelated[index].languageTo,
                  formTo: lexiconRelated[index].formTo,
                  glossTo: lexiconRelated[index].glossTo,
                  refSources: lexiconRelated[index].refSources,
                  relatedId: lexiconRelated[index].relatedId,
                );
              }));
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: BlueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            // fadeCurve: Curves.decelerate,
                            // animationDuration: const Duration(milliseconds: 400),
                            // scrollAnimationDuration: const Duration(milliseconds: 400),
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: lexiconRelated.isEmpty
                              ? Text("no related words found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey))
                              : Text(
                                  "related word" +
                                      (lexiconRelated.length > 1 ? "s" : ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin)),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class NotesCard extends StatelessWidget {
  List<EntryDoc> entryDoc;
  final ValueChanged<String> parentAction;

  NotesCard(this.entryDoc, this.parentAction);

  @override
  Widget build(BuildContext context) {
    buildNote() {
      if (entryDoc.isEmpty) {
        return Container();
      } else {
        return Container(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          color: NotepaperWhite,
          child: Html(
            data: entryDoc[0].doc ?? '',
            style: {
              "body": Style(
                fontSize: FontSize(15.0),
                color: ThemeTextColour,
              ),
            },
            onLinkTap: (
                String? url,
                RenderContext context,
                Map<String, String> attributes,
                dom.Element? element,
                ) {
              //setState(() {
              parentAction(url ?? '');
            },
          ),
        );
      }
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: BlueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            // fadeCurve: Curves.decelerate,
                            // animationDuration: const Duration(milliseconds: 400),
                            // scrollAnimationDuration: const Duration(milliseconds: 400),
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: entryDoc.isEmpty
                              ? Text(
                                  "no notes found",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: LightBlueGrey),
                                )
                              : Text(
                                  "notes",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildNote(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
