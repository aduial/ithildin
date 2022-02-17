import 'package:flutter/material.dart';
import 'package:ithildin/model/lexicon_cognate.dart';
import 'package:ithildin/model/lexicon_header.dart';
import 'package:ithildin/screen/related_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme.dart';
import '../db/eldamo_db.dart';
import '../model/entry_doc.dart';
import '../model/lexicon_gloss.dart';
import '../model/lexicon_related.dart';
import '../model/simplexicon.dart';
import 'cognate_list.dart';
import 'gloss_list.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen(this.entryId, {Key? key}) : super(key: key);
  final int entryId;

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? preferences;
  List<bool> _toggleState = List.generate(4, (_) => true);
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
    initializePreference().whenComplete(() {
      // now preferences is accessible
      print(preferences?.getKeys());
    });
    getToggleState();
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

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  saveToggleState(int index) async {
    _toggleState[index] = !_toggleState[index];

    print("toggled: " +
        index.toString() +
        " to " +
        (_toggleState[index] == true ? "true" : "false"));
    preferences = await SharedPreferences.getInstance();
    // setState(() {
    preferences?.setStringList(
      "toggleState",
      _toggleState.map((e) => e ? 'true' : 'false').toList(),
    );
    preferences?.setBool('repeat', true);
    // });
  }

  getToggleState() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      _toggleState = (preferences
              ?.getStringList('toggleState')
              ?.map((e) => e == 'true' ? true : false)
              .toList() ??
          [false, false, false, false]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Navigation back button
          Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [VeryVeryDark, InvisibleDark],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 40, 16, 16),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Theme.of(context).primaryColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).buttonColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Header (form)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      isDataLoading ? "Loading..." : entry.form,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w300, color: MiddleGreen),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Header row (form)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 4, 2),
                      child: Text(
                        isDataLoading
                            ? "Loading..."
                            : (header.language == null)
                                ? ''
                                : header.language!.toUpperCase() + '.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    )),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 4, 4, 2),
                    child: Text(
                      isDataLoading
                          ? "Loading..."
                          : (header.type == null)
                              ? ''
                              : header.type!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 4, 4, 2),
                    child: Text(
                      isDataLoading
                          ? "Loading..."
                          : (header.gloss == null)
                              ? ''
                              : ('"' + header.gloss! + '"'),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontStyle: FontStyle.italic, color: BluerGrey),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //
          //
          // divider glosses
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: 1,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),

          // row glosses
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[0]
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[0] ? 50.0 : 0.0,
              alignment:
                  _toggleState[0] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Visibility(
                visible: _toggleState[0],
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Icon(
                          Icons.list_alt_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 2),
                        child: Text(
                          'glosses',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // List of glosses
          Flexible(
            flex: 5,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[0] ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[0] ? 100.0 : 0.0,
              alignment:
                  _toggleState[0] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isDataLoading
                        ? const CircularProgressIndicator()
                        : lexiconGlosses.isEmpty
                            ? const Text(
                                'No glosses found',
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 12),
                              )
                            : Expanded(
                                child:
                                ListView.builder(
                                    primary: false,
                                    itemCount: lexiconGlosses.length,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                    shrinkWrap: true,
                                    // itemExtent: 40.0,
                                    itemBuilder: (context, index) {
                                      return GlossListItem(
                                        entryId: lexiconGlosses[index].entryId,
                                        gloss: lexiconGlosses[index].gloss,
                                        reference:
                                            lexiconGlosses[index].reference,
                                      );
                                    })
                    ),
                  ],
                ),
              ),
            ),
          ),
          //
          // divider cognates
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[0]
                  ? MediaQuery.of(context).size.width * 0.93
                  : MediaQuery.of(context).size.width * 0.93,
              height: _toggleState[0] ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          //
          // row cognates
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[1]
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[1] ? 100.0 : 0.0,
              alignment:
                  _toggleState[1] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Visibility(
                visible: _toggleState[1],
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                        child: Icon(
                          Icons.group_work_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Text(
                          'cognates',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // List cognates
          Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[1] ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[1] ? 100.0 : 0.0,
              alignment:
                  _toggleState[1] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isDataLoading
                        ? const CircularProgressIndicator()
                        : lexiconCognates.isEmpty
                            ? const Text(
                                'No cognates found',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 12),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    primary: false,
                                    itemCount: lexiconCognates.length,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return CognateListItem(
                                        entryId: lexiconCognates[index].entryId,
                                        language: lexiconCognates[index].language,
                                        form: lexiconCognates[index].form,
                                        gloss: lexiconCognates[index].gloss,
                                        sources: lexiconCognates[index].sources,
                                      );
                                    })),
                  ],
                ),
              ),
            ),
          ),
          //
          // divider related
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[1]
                  ? MediaQuery.of(context).size.width * 0.93
                  : MediaQuery.of(context).size.width * 0.93,
              height: _toggleState[1] ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          //
          // row related
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[2]
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[2] ? 100.0 : 0.0,
              alignment:
                  _toggleState[2] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Visibility(
                visible: _toggleState[2],
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                        child: Icon(
                          Icons.people_outline,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Text(
                          'related',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // list related
          Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[2] ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[2] ? 100.0 : 0.0,
              alignment:
                  _toggleState[2] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isDataLoading
                        ? const CircularProgressIndicator()
                        : lexiconRelated.isEmpty
                            ? const Text(
                                'No related entries found',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 12),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    primary: false,
                                    itemCount: lexiconRelated.length,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return RelatedListItem(
                                        entryId: lexiconRelated[index].entryId,
                                        formFrom:
                                            lexiconRelated[index].formFrom,
                                        glossFrom:
                                            lexiconRelated[index].glossFrom,
                                        relation:
                                            lexiconRelated[index].relation,
                                        formTo: lexiconRelated[index].formTo,
                                        glossTo: lexiconRelated[index].glossTo,
                                      );
                                    })),
                  ],
                ),
              ),
            ),
          ),
          //
          // divider notes
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[2]
                  ? MediaQuery.of(context).size.width * 0.93
                  : 0,
              height: _toggleState[2] ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          //
          // row notes
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[3]
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[3] ? 50.0 : 0.0,
              alignment:
                  _toggleState[3] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Visibility(
                visible: _toggleState[3],
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                        child: Icon(
                          Icons.auto_stories_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Text(
                          'notes',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // scrollview notes
          Flexible(
            flex: 4,
            fit: FlexFit.loose,
            child: AnimatedContainer(
              width: _toggleState[3] ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: _toggleState[3] ? 100.0 : 0.0,
              alignment:
                  _toggleState[3] ? Alignment.topLeft : Alignment.topLeft,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12, 0, 12, 4),

              child: isDataLoading
                  ? const CircularProgressIndicator()
                  : entryDocs.isEmpty
                      ? const Text(
                          'No documents found',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                            child: Text(
                              entryDocs[0].doc??'',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
      // toggle buttons
      bottomNavigationBar: BottomAppBar(
          color: BlueGrey,
          child: Container(
            height: 40.0,
            child: Center(
              child: ToggleButtons(
                children: const <Widget>[
                  Icon(Icons.list_alt_outlined),
                  Icon(Icons.group_work_outlined),
                  Icon(Icons.people_outline),
                  Icon(Icons.auto_stories_outlined),
                ],
                color: DisabledButtons,
                selectedColor: BrightGreen,
                fillColor: BluerGrey,
                splashColor: BrightBlue,
                isSelected: _toggleState,
                onPressed: (int index) {
                  setState(() {
                    saveToggleState(index);
                  });
                },
              ),
            ),
          )),
    );
  }
}
