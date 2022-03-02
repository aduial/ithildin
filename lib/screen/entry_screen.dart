import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ithildin/model/lexicon_cognate.dart';
import 'package:ithildin/model/lexicon_header.dart';
import 'package:ithildin/screen/related_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../config/colours.dart';
import '../db/eldamo_db.dart';
import '../model/entry_doc.dart';
import '../model/lexicon_gloss.dart';
import '../model/lexicon_related.dart';
import '../model/simplexicon.dart';
import 'cognate_list.dart';
import 'gloss_list.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;

class EntryScreen extends StatefulWidget {
  const EntryScreen(this.entryId, {Key? key}) : super(key: key);
  final int entryId;

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataLoading = true;
  bool cognatesVisible = false;

  late Simplexicon entry;
  late LexiconHeader header;
  late List<LexiconGloss> lexiconGlosses;
  late List<LexiconCognate> lexiconCognates;
  late List<LexiconRelated> lexiconRelated;
  late List<EntryDoc> entryDocs;

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
    await loadEntryDocs();
  }

  Future loadEntry() async {
    setState(() => isDataLoading = true);
    List<Simplexicon> entryList =
        await EldamoDb.instance.loadSimplexicon(widget.entryId);
    entry = entryList[0];
    setState(() => isDataLoading = false);
  }

  Future loadHeader() async {
    setState(() => isDataLoading = true);
    List<LexiconHeader> headerList =
        await EldamoDb.instance.loadLexiconHeader(widget.entryId);
    if (headerList.isNotEmpty) {
      header = headerList[0];
    }
    setState(() => isDataLoading = false);
  }

  Future loadLexiconGlosses() async {
    setState(() => isDataLoading = true);
    lexiconGlosses = await EldamoDb.instance.loadLexiconGlosses(widget.entryId);
    setState(() => isDataLoading = false);
  }

  Future loadLexiconCognates() async {
    setState(() => isDataLoading = true);
    lexiconCognates =
        await EldamoDb.instance.loadLexiconCognates(widget.entryId);
    setState(() => isDataLoading = false);
  }

  Future loadLexiconRelated() async {
    setState(() => isDataLoading = true);
    lexiconRelated = await EldamoDb.instance.loadLexiconRelated(widget.entryId);
    setState(() => isDataLoading = false);
  }

  Future loadEntryDocs() async {
    setState(() => isDataLoading = true);
    entryDocs = await EldamoDb.instance.loadEntryDocs(widget.entryId);
    setState(() => isDataLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: OffWhite,

      appBar: AppBar(
        backgroundColor: BlueGrey,
        title: Text(
          isDataLoading ? "Loading..." : entry.form,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w300, color: Laurelin),
        ),
      ),

      body: isDataLoading
          ? Text("loading ...")
          : ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.yellow,
                useInkWell: true,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  headerCard(header, isDataLoading),
                  GlossCard(lexiconGlosses, isDataLoading),
                  CognateCard(lexiconCognates, isDataLoading),
                  RelatedCard(lexiconRelated, isDataLoading),
                  NotesCard(entryDocs, isDataLoading),
                ],
              ),
            ),


    );
  }
}

class headerCard extends StatelessWidget {
  LexiconHeader header;
  bool isDataLoading;

  headerCard(this.header, this.isDataLoading);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 14, 12, 4),
      child: isDataLoading
          ? Text("loading ...")
          : RichText(
              text: TextSpan(
                text: header.language!.toUpperCase() + '. ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(
                    text: header.type ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: ' "' + header.gloss! + '"',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                ],
              ),
            ),
    );
  }
}

class GlossCard extends StatelessWidget {
  List<LexiconGloss> lexiconGlosses;
  bool isDataLoading;

  GlossCard(this.lexiconGlosses, this.isDataLoading);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: OffWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3),
              primary: false,
              itemCount: lexiconGlosses.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GlossListItem(
                  entryId: lexiconGlosses[index].entryId,
                  gloss: '"' + lexiconGlosses[index].gloss + '" ',
                  reference: lexiconGlosses[index].reference,
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
                          child: lexiconGlosses.isEmpty
                              ? Text("no glosses found",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: LightBlueGrey))
                              : Text(
                            "gloss" + (lexiconGlosses.length > 1 ? "es" : "") ,
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
  bool isDataLoading;

  CognateCard(this.lexiconCognates, this.isDataLoading);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: OffWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3),
              primary: false,
              itemCount: lexiconCognates.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CognateListItem(
                  entryId: lexiconCognates[index].entryId,
                  language: lexiconCognates[index].language + ' ',
                  form: lexiconCognates[index].form + ' ',
                  gloss: ' "' + lexiconCognates[index].gloss! + '" ',
                  sources: lexiconCognates[index].sources,
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
                            "cognate" + (lexiconCognates.length > 1 ? "s" : "") ,
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
  bool isDataLoading;

  RelatedCard(this.lexiconRelated, this.isDataLoading);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Container(
          color: OffWhite,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3),
              primary: false,
              itemCount: lexiconRelated.length,
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RelatedListItem(
                  entryId: lexiconRelated[index].entryId,
                  formFrom: lexiconRelated[index].formFrom!,
                  glossFrom: lexiconRelated[index].glossFrom!,
                  relation: lexiconRelated[index].relation,
                  formTo: lexiconRelated[index].formTo!,
                  glossTo: lexiconRelated[index].glossTo,
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
                                  "related word" + (lexiconRelated.length > 1 ? "s" : "") ,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Laurelin)
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

class NotesCard extends StatelessWidget {
  List<EntryDoc> entryDoc;
  bool isDataLoading;

  NotesCard(this.entryDoc, this.isDataLoading);

  @override
  Widget build(BuildContext context) {
    buildNote() {
      if (entryDoc.isEmpty) {
        return Container();
      } else {
        return Container(
          color: OffWhite,
          child: Html(data: entryDoc[0].doc ?? ''),
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
