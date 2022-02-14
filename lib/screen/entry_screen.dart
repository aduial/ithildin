import 'package:flutter/material.dart';
import 'package:ithildin/model/lexicon_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme.dart';
import '../db/eldamo_db.dart';
import '../model/simplexicon.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen(this.entryId, {Key? key}) : super(key: key);
  final int entryId;

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? preferences;
  List<bool> _toggleState = List.generate(4, (_) => false);
  bool isDataLoading = true;

  late Simplexicon entry;
  late LexiconHeader header;

  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      // now preferences is accessible
      print(preferences?.getKeys());
    });
    getToggleState();
    getInitData();

    setState(() {});
  }

  Future getInitData() async {
    await loadEntry();
    await loadHeader();
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

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  saveToggleState(int index) async {
    _toggleState[index] = !_toggleState[index];
    print("toggled: " + index.toString());
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
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  decoration: BoxDecoration(
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
                padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 16),
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
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
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

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      isDataLoading ? "Loading..." : entry.form,
                      style: Theme.of(context).textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w300, color: MiddleGreen),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 2),
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
                    padding: EdgeInsetsDirectional.fromSTEB(2, 4, 4, 2),
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
                    padding: EdgeInsetsDirectional.fromSTEB(2, 4, 4, 2),
                    child: Text(
                      isDataLoading
                          ? "Loading..."
                          : (header.gloss == null)
                              ? ''
                              : ('"' + header.gloss! + '"'),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontStyle: FontStyle.italic, color: BluerGrey),
                      //Theme.of(context).textTheme.bodyText2.copyWith.FontStyle.italic,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 4, 4, 0),
                    child: Text(
                      isDataLoading
                          ? "Loading..."
                          : (header.cat == null)
                              ? ''
                              : header.cat!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),

          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          //
          //
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 4),
          //         child: Text(
          //           isDataLoading
          //               ? "Loading..."
          //               : (header.language == null) ? '' : header.language!,
          //           style: Theme.of(context).textTheme.bodyText1,
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 4),
          //         child: Text(
          //           isDataLoading
          //               ? "Loading..."
          //               : (header.form == null) ? '' : header.form!,
          //           style: Theme.of(context).textTheme.bodyText1,
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 4),
          //         child: Text(
          //           isDataLoading
          //               ? "Loading..."
          //               : (header.type == null) ? '' : header.type!,
          //           style: Theme.of(context).textTheme.bodyText1,
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 4),
          //         child: Text(
          //           isDataLoading
          //               ? "Loading..."
          //           // : (header.gloss == null) ? '' : header.gloss!,
          //               : (header.gloss == null) ? '' : ('"' + header.gloss! + '"'),
          //           style: Theme.of(context).textTheme.bodyLarge,
          //
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
          //         child: Text(
          //           isDataLoading
          //               ? "Loading..."
          //               : (header.cat == null) ? '' : header.cat!,
          //           style: Theme.of(context).textTheme.bodyText1,
          //         ),
          //       ),
          //     ],
          //   ),
          //
          // ),

          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                  child: Text(
                    'glosses',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                  child: Text(
                    'cognates',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Icon(
                    Icons.text_snippet_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                  child: Text(
                    'notes',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                            child: Text(
                              '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Center(
                child: ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.home_filled),
                    Icon(Icons.home_repair_service),
                    Icon(Icons.add_location),
                    Icon(Icons.payment),
                  ],
                  isSelected: _toggleState,
                  onPressed: (int index) {
                    setState(() {
                      saveToggleState(index);
                    });
                  },
                ),
              )),
        ],
      ),
      // appBar: AppBar(),
      // body: Center(
      //   child: Text('Detail page for Entry# ' + widget.entryId.toString()),
      // ),
    );
  }
}
