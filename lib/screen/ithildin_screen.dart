import 'package:flutter/cupertino.dart';
import 'package:ithildin/db/eldamo_db.dart';
import 'package:ithildin/model/language.dart';
import 'package:ithildin/model/simplexicon.dart';
import 'package:ithildin/screen/slex_list.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../config/config.dart';
import '../config/colours.dart';

class IthildinScreen extends StatefulWidget {
  const IthildinScreen({Key? key}) : super(key: key);

  @override
  _IthildinScreenState createState() => _IthildinScreenState();
}

class _IthildinScreenState extends State<IthildinScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keyLangSetButton = GlobalKey();
  GlobalKey keyEldarinLangSelect = GlobalKey();
  GlobalKey keyModernLangSelect = GlobalKey();
  GlobalKey keyFormOrGloss = GlobalKey();
  GlobalKey keySearchField = GlobalKey();
  GlobalKey keyResultList = GlobalKey();

  late List<Language> eldarinLanguages;
  late List<Language> modernLanguages;

  late List<Simplexicon> simplexicons;
  final searchController = TextEditingController();

  int? _formLangId = 0;
  int? _glossLangId = 0;
  bool isLanguageLoading = false;
  bool isSimplexiconLoading = true;

  int _formOrGloss = 0;

  @override
  void initState() {
    super.initState();
    getInitData();
    // Start listening to changes.
    searchController.addListener(_doSearch);
  }

  Future getInitData() async {
    await loadLanguages();
    // get initial words
    await simplexiconFormFilter('');
  }

  @override
  void dispose() {
    EldamoDb.instance.close();
    searchController.dispose();
    super.dispose();
  }

  void _doSearch() {
    /// query simplexicon
    if (_formOrGloss == 0) {
      simplexiconFormFilter(searchController.text);
    } else {
      simplexiconGlossFilter(searchController.text);
    }
    // }
  }

  Future reloadEldarinLanguages() async {
    setState(() => isLanguageLoading = true);
    eldarinLanguages = await EldamoDb.instance.loadEldarinLanguages();
    setState(() => isLanguageLoading = false);
  }

  // also set initial indexes, after lists have loaded
  Future loadLanguages() async {
    setState(() => isLanguageLoading = true);
    eldarinLanguages = await EldamoDb.instance.loadEldarinLanguages();
    _formLangId = eldarinLanguages[eldarinStartIndex].id;
    modernLanguages = await EldamoDb.instance.loadModernLanguages();
    _glossLangId = modernLanguages[modernStartIndex].id;
    setState(() => isLanguageLoading = false);
  }

  Future loadSimplexicons() async {
    setState(() => isSimplexiconLoading = true);
    simplexicons = await EldamoDb.instance.loadSimplexicons();
    setState(() => isSimplexiconLoading = false);
  }

  Future simplexiconFormFilter(String formFilter) async {
    setState(() => isSimplexiconLoading = true);
    simplexicons = await EldamoDb.instance
        .simplexiconFormFilter(formFilter, _formLangId!, _glossLangId!);
    setState(() => isSimplexiconLoading = false);
  }

  Future simplexiconGlossFilter(String glossFilter) async {
    setState(() => isSimplexiconLoading = true);
    simplexicons = await EldamoDb.instance
        .simplexiconGlossFilter(glossFilter, _formLangId!, _glossLangId!);
    setState(() => isSimplexiconLoading = false);
  }

  void onSelectLangSet(item) {
    EldamoDb.instance.setLangCatWhere(catMap[item].toString());
    reloadEldarinLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: DarkBlueGrey,
        automaticallyImplyLeading: true,
        leading: Builder(
          builder: (BuildContext context) {
            return PopupMenuButton<String>(
                color: Laurelin,
                elevation: 4,
                icon: Icon(
                  CupertinoIcons.square_stack_3d_down_right,
                  color: BrightGreen,
                  size: 24.0,
                  semanticLabel: 'choose language set',
                  key: keyLangSetButton,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                onSelected: onSelectLangSet,
                itemBuilder: (BuildContext context) {
                  return langCategories.map((String choice) {
                    return PopupMenuItem<String>(
                      child: Text(choice),
                      value: choice,
                    );
                  }).toList();
                });
          },
        ),
        title: const Text("word search"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle),
            color: BrightestBlue,
            tooltip: 'help',
            onPressed: () {
              showTutorial();
            },
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: BlueGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// top row with two searchable dropdown lists for languages
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// dropdown list for Eldarin languages
                    /// (BottomSheet Mode with searchBox)
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                          child: DropdownSearch<Language>(
                            key: keyEldarinLangSelect,
                            mode: Mode.BOTTOM_SHEET,
                            items: isLanguageLoading
                                ? [const Language(id: 0, name: "Loading...")]
                                : eldarinLanguages.isEmpty
                                    ? [
                                        const Language(
                                            id: 0, name: "no languages found")
                                      ]
                                    : eldarinLanguages,

                            /// pre-select Sindarin at startup
                            selectedItem: isLanguageLoading
                                ? null
                                : eldarinLanguages[eldarinStartIndex],

                            dropdownSearchDecoration: const InputDecoration(
                              filled: true,
                              fillColor: BrightGreen,
                              hintText: "tap to change",
                              prefixIconColor: DarkGreen,
                              contentPadding: EdgeInsets.fromLTRB(12, 8, 0, 0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                            ),

                            // selectedItem: "Sindarin",
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: const InputDecoration(
                                labelText: "filter on",
                                filled: true,
                                fillColor: Laurelin,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 8, 0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                              ),
                            ),

                            popupTitle: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: DarkerGreen,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'select Eldarin language',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            onChanged: (Language? eldarinLang) {
                              _formLangId = eldarinLang?.id;
                              _doSearch();
                            },
                          ),
                        ),
                      ),
                    ),

                    /// dropdown list for modern languages
                    /// (BottomSheet Mode with searchBox)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: const BoxDecoration(),
                      child: DropdownSearch<Language>(
                        key: keyModernLangSelect,
                        mode: Mode.BOTTOM_SHEET,
                        items: isLanguageLoading
                            ? [const Language(id: 0, name: "Loading...")]
                            : modernLanguages.isEmpty
                                ? [
                                    const Language(
                                        id: 0, name: "no languages found")
                                  ]
                                : modernLanguages,
                        // preselect English at startup
                        selectedItem: isLanguageLoading
                            ? null
                            : modernLanguages[modernStartIndex],

                        dropdownSearchDecoration: const InputDecoration(
                          filled: true,
                          fillColor: Telperion,
                          hintText: "tap to change",
                          prefixIconColor: DarkBrown,
                          contentPadding: EdgeInsets.fromLTRB(12, 8, 0, 0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),

                        // selectedItem: "Sindarin",
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Telperion,
                            labelText: "filter on",
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                          ),
                        ),

                        popupTitle: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: MiddleBrown,
                            //Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'select language',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        popupShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        onChanged: (Language? modernLang) {
                          _glossLangId = modernLang?.id;
                          _doSearch();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //
              // Form-Gloss toggle button
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleSwitch(
                      key: keyFormOrGloss,
                      minHeight: 44.0,
                      minWidth: 70.0,
                      cornerRadius: 15.0,
                      borderWidth: 1,
                      borderColor: const [Colors.white],
                      dividerColor: BlueGrey,
                      activeBgColors: const [
                        [BrightGreen],
                        [Telperion]
                      ],
                      activeFgColor: VeryVeryDark,
                      inactiveBgColor: BlueGrey,
                      inactiveFgColor: DarkerBlueGrey,
                      fontSize: 18,

                      totalSwitches: 2,
                      initialLabelIndex: _formOrGloss,
                      labels: const ['form', 'gloss'],
                      animate: true,
                      // with just animate set to true, default curve = Curves.easeIn
                      curve: Curves.ease,
                      // animate
                      onToggle: (index) {
                        setState(() {
                          _formOrGloss = index!;
                        });
                        _doSearch();
                      },
                    ),

                    // search box
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        height: 50,
                        // constraints: BoxConstraints(
                        //   maxWidth: MediaQuery.of(context).size.width * 0.7,
                        // ),
                        decoration: const BoxDecoration(),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextField(
                            key: keySearchField,
                            // cursorHeight: ,
                            controller: searchController,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: BrightBlue,
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0)))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                  child: isSimplexiconLoading
                      ? Container()
                      : simplexicons.isEmpty
                          ? const Text(
                              'No entries found',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          : ListView.builder(
                              key: keyResultList,
                              itemCount: simplexicons.length,
                              padding: const EdgeInsets.all(4.0),
                              shrinkWrap: true,
                              itemExtent: 40.0,
                              itemBuilder: (context, index) {
                                return SLexListItem(
                                  id: simplexicons[index].id,
                                  formLangAbbr:
                                      simplexicons[index].formLangAbbr,
                                  mark: simplexicons[index].mark!,
                                  form: simplexicons[index].form,
                                  gloss: simplexicons[index].gloss,
                                  isRoot:
                                      simplexicons[index].entryClassId == 603,
                                );
                              })),
            ],
          ),
        ),
      ),
    );
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: TanteRiaSAvonds,
      textSkip: "Cancel",
      paddingFocus: 10,
      opacityShadow: 0.9,
      // onFinish: () {
      //   print("finish");
      // },
      // onClickTarget: (target) {
      //   print('onClickTarget: $target');
      // },
      // onClickOverlay: (target) {
      //   print('onClickOverlay: $target');
      // },
      // onSkip: () {
      //   print("skip");
      // },
    )..show();
  }

  void initTargets() {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "keyLangSetButton",
        keyTarget: keyLangSetButton,
        enableOverlayTab: true,
        enableTargetTab: true,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Choose language set",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose what languages you want available in the language selector: from Minimal "
                      "(only Quenya and Sindarin), via Basic (largest vocabularies) to Complete (everything from Eldamo.org).",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Languages in the Basic set have thousands of entries, "
                      "decreasing to a handful for the most obscure languages.\n\n",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyEldarinLangSelect",
        keyTarget: keyEldarinLangSelect,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Eldarin language chooser",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Shows the current Eldarin language.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                      "Tap to select another language from the active Set in the "
                      "pop-up list below.\n\nScroll if the list is too long, or "
                      "filter by typing one or more characters in the field "
                      "marked 'Filter on'.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyModernLangSelect",
        keyTarget: keyModernLangSelect,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "language chooser",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                      "(not currently active because only English is available at this time)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Disabled),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyFormOrGloss",
        keyTarget: keyFormOrGloss,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Form - Gloss switch",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                      "Set to search on forms (Eldarin words) or glosses (their "
                      "translations)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keySearchField",
        keyTarget: keySearchField,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "search field",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                      "Tap and enter one or more characters to search",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyResultList",
        targetPosition: TargetPosition(
          Size(MediaQuery. of(context).size.width * 0.90,
            MediaQuery. of(context).size.height * 0.3),
          Offset(20.0, MediaQuery. of(context).size.height * 0.3),
        ),
        // keyTarget: keyResultList,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            // align: ContentAlign.custom,
            // customPosition: ,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      "result list",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Text(
                      "Shows the list of entries matching the search string "
                      "(word roots are shown in an alternate colour). "
                          "Tap on a word to see available details.\n\n"
                          "Author(s) of neo-entries are shown in the details "
                          "screen insofar they were recorded in Eldamo.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        child: Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 0,
      ),
    );
  }
}
