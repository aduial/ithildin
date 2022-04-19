import 'dart:async';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:ithildin/config/user_preferences.dart';
import 'package:ithildin/db/eldamo_db.dart';
import 'package:ithildin/model/language.dart';
import 'package:ithildin/model/simplexicon.dart';
import 'package:ithildin/screen/search_match.dart';
import 'package:ithildin/screen/slex_list.dart';
import 'dart:math' as math;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:animations/animations.dart';

import '../config/config.dart';
import '../config/colours.dart';
import 'about_us.dart';
import 'language_sets.dart';

class IthildinScreen extends StatefulWidget {
  const IthildinScreen({Key? key}) : super(key: key);

  @override
  _IthildinScreenState createState() => _IthildinScreenState();
}

class _IthildinScreenState extends State<IthildinScreen> {
  final drawerController = AdvancedDrawerController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keyLangSetButton = GlobalKey();
  GlobalKey keyEldarinLangSelect = GlobalKey();
  GlobalKey keyGlossLangSelect = GlobalKey();
  GlobalKey keyFormOrGloss = GlobalKey();
  GlobalKey keySearchField = GlobalKey();
  GlobalKey keyResultList = GlobalKey();

  late List<Language> eldarinLanguageSet;
  late List<Language> glossLanguageSet;

  late List<Simplexicon> simplexicons;
  final searchController = TextEditingController();

  final ScrollController controller = ScrollController();

  bool isLanguageDataLoading = false;
  bool isSimplexiconLoading = true;

  bool usedRegex = false;

  int _formOrGloss = 0;

  Language? _activeEldarinLanguage;
  Language? _activeGlossLanguage;

  @override
  void initState() {
    super.initState();
    getInitData();
    // Start listening to changes.
    searchController.addListener(_doSearch);
  }

  Future getInitData() async {
    setState(() => isLanguageDataLoading = true);
    await loadActiveLanguages();
    await loadLanguageAndSets();
    setState(() => isLanguageDataLoading = false);

    await simplexiconFormFilter('');
  }

  // gets the languages stored in the Userpreferences;
  // if null, get the ones defined in config.dart
  Future loadActiveLanguages() async {
    _activeEldarinLanguage = await EldamoDb.instance.loadLanguage(
        UserPreferences.getActiveEldarinLangId() ?? defaultEldarinLangId);
    _activeGlossLanguage = await EldamoDb.instance.loadLanguage(
        UserPreferences.getActiveGlossLangId() ?? defaultGlossLangId);
  }

  Future loadLanguageAndSets() async {
    eldarinLanguageSet = await EldamoDb.instance.loadEldarinLanguageSet();
    glossLanguageSet = await EldamoDb.instance.loadGlossLanguageSet();
  }

  Future reloadEldarinLanguageSet() async {
    setState(() => isLanguageDataLoading = true);
    eldarinLanguageSet = await EldamoDb.instance.loadEldarinLanguageSet();
    setState(() => isLanguageDataLoading = false);
  }

  Future loadSimplexicons() async {
    setState(() => isSimplexiconLoading = true);
    simplexicons = await EldamoDb.instance.loadSimplexicons();
    setState(() => isSimplexiconLoading = false);
  }

  Future simplexiconFormFilter(String formFilter) async {
    setState(() => isSimplexiconLoading = true);
    if ((UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex) < 4){
      simplexicons = await EldamoDb.instance.simplexiconFormFilter(
          formFilter, _activeEldarinLanguage!.id, _activeGlossLanguage!.id);
    } else {
      usedRegex = true;
      simplexicons = await EldamoDb.instance.simplexiconFormRegexFilter(
          formFilter, _activeEldarinLanguage!.id, _activeGlossLanguage!.id);
    }
    setState(() => isSimplexiconLoading = false);
  }

  Future simplexiconGlossFilter(String glossFilter) async {
    setState(() => isSimplexiconLoading = true);
    if ((UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex) < 4) {
      simplexicons = await EldamoDb.instance.simplexiconGlossFilter(
          glossFilter, _activeEldarinLanguage!.id, _activeGlossLanguage!.id);
    } else {
      usedRegex = true;
      simplexicons = await EldamoDb.instance.simplexiconGlossRegexFilter(
          glossFilter, _activeEldarinLanguage!.id, _activeGlossLanguage!.id);
    }
    setState(() => isSimplexiconLoading = false);
  }

  void setActiveEldarinLang(Language activeEldarinLang) {
    UserPreferences.setActiveEldarinLangId(activeEldarinLang.id);
    _activeEldarinLanguage = activeEldarinLang;
  }

  void setActiveGlossLang(Language activeGlossLang) {
    UserPreferences.setActiveGlossLangId(activeGlossLang.id);
    _activeGlossLanguage = activeGlossLang;
  }

  void handleSettingsButtonPressed() {
    drawerController.showDrawer();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _doSearch() {
    if (_formOrGloss == 0) {
      simplexiconFormFilter(searchController.text);
    } else {
      simplexiconGlossFilter(searchController.text);
    }
  }

  void clearSearch(){
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: TanteRiaSAvonds,
      controller: drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: VeryVeryDark,
            blurRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: RegularResultBGColour,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: handleSettingsButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: drawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible
                        ? CupertinoIcons.back
                        : CupertinoIcons.settings,
                    color: BrightestBlue,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: const Text("word search"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(CupertinoIcons.info_circle),
              color: LightPink,
              tooltip: 'about us',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.question_circle),
              color: Telperion,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 4, 0),
                            child: DropdownSearch<Language>(
                              key: keyEldarinLangSelect,
                              mode: Mode.BOTTOM_SHEET,
                              items: isLanguageDataLoading
                                  ? [const Language(id: 0, name: "Loading...")]
                                  : eldarinLanguageSet.isEmpty
                                      ? [
                                          const Language(
                                              id: 0, name: "no languages found")
                                        ]
                                      : eldarinLanguageSet,
                              selectedItem: isLanguageDataLoading
                                  ? null
                                  : _activeEldarinLanguage,
                              dropdownBuilder: _dropDownBuilder,
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: getLangSetColour(true),

                                hintText: "tap to change",
                                prefixIconColor: getLangSetColour(false),
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 8, 0, 0),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: TanteRia),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: "filter on",
                                  filled: true,
                                  fillColor: getLangSetColour(true),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 12, 8, 0),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: LightBlueGrey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                ),
                              ),
                              popupTitle: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: getLangSetColour(false),
                                  borderRadius: const BorderRadius.only(
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
                                setActiveEldarinLang(eldarinLang!);
                                _doSearch();
                              },
                            ),
                          ),
                        ),
                      ),

                      /// dropdown list for gloss languages
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        decoration: const BoxDecoration(),
                        child: DropdownSearch<Language>(
                          key: keyGlossLangSelect,
                          mode: Mode.BOTTOM_SHEET,
                          items: isLanguageDataLoading
                              ? [const Language(id: 0, name: "Loading...")]
                              : glossLanguageSet.isEmpty
                                  ? [
                                      const Language(
                                          id: 0, name: "no languages found")
                                    ]
                                  : glossLanguageSet,
                          // preselect English at startup
                          selectedItem: isLanguageDataLoading
                              ? null
                              : _activeGlossLanguage,
                          dropdownBuilder: _dropDownBuilder,
                          dropdownSearchDecoration: const InputDecoration(
                            filled: true,
                            fillColor: Telperion,
                            hintText: "tap to change",
                            prefixIconColor: DarkBrown,
                            contentPadding: EdgeInsets.fromLTRB(12, 8, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: TanteRia),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                          ),

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
                          onChanged: (Language? glossLang) {
                            setActiveGlossLang(glossLang!);
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
                        borderColor: const [White],
                        dividerColor: BlueGrey,
                        activeBgColors: [
                          [getLangSetColour(true)],
                          const [Telperion]
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
                              style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: TanteRiaSAvonds, fontWeight: FontWeight.w300, fontSize: 18),
                              controller: searchController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: BrightBlue,
                                  hintText: "Search",
                                  prefixIcon: Icon(
                                    getMatchMethodIcon(),
                                    color: TanteRiaSAvonds,
                                  ),
                                  border: const OutlineInputBorder(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            : DraggableScrollbar.semicircle(
                                alwaysVisibleScrollThumb: false,
                                backgroundColor: DarkerBlueGrey,
                                padding: EdgeInsets.only(right: 4.0),
                                labelTextBuilder: (offset) {
                                  final int currentItem = controller.hasClients
                                      ? ((controller.offset /
                                                  controller.position
                                                      .maxScrollExtent) *
                                              (simplexicons.length - 1))
                                          .floor()
                                      : 0;
                                  return Text(
                                    simplexicons[currentItem]
                                        .form[0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: BrightGreen, fontSize: 14),
                                  );
                                },
                                controller: controller,
                                child: ListView.builder(
                                    controller: controller,
                                    key: keyResultList,
                                    itemCount: simplexicons.length,
                                    padding: const EdgeInsets.all(4.0),
                                    // shrinkWrap: true,
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
                                            simplexicons[index].entryClassId ==
                                                603,
                                      );
                                    }),
                              )),
              ],
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  child: const CircleAvatar(
                    // radius: 10,
                    backgroundImage:
                        ExactAssetImage('assets/images/appicon-ios-512.png'),
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: TanteRia,
                      width: 4.0,
                    ),
                  ),
                ),
                OpenContainer<bool>(
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: const Duration(milliseconds: 500),
                  openColor: RegularResultBGColour,
                  closedColor: RegularResultBGColour,
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return const LanguageSets();
                  },
                  onClosed: langSetPreferenceClosed,
                  tappable: false,
                  closedShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ListTile(
                      tileColor: TanteRiaSAvonds,
                      leading: const Icon(
                          CupertinoIcons.square_stack_3d_down_right,
                          color: BrightGreen),
                      onTap: openContainer,
                      title: Text('Language sets'),
                      textColor: Ithildin,
                    );
                  },
                ),
                OpenContainer<bool>(
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: const Duration(milliseconds: 500),
                  openColor: RegularResultBGColour,
                  closedColor: RegularResultBGColour,
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return const SearchMatch();
                  },
                  onClosed: searchMatchPreferenceClosed,
                  tappable: false,
                  closedShape: const RoundedRectangleBorder(),
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ListTile(
                      tileColor: TanteRiaSAvonds,
                      leading: const Icon(Icons.manage_search,
                          color: LightPink),
                      onTap: openContainer,
                      title: Text('Search matching'),
                      textColor: Ithildin,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void langSetPreferenceClosed(bool? langSetChanged) {
    if (langSetChanged ?? false) {
      reloadEldarinLanguageSet();
      String setName = langCategories[
          UserPreferences.getLanguageSet() ?? defaultLanguageSetIndex];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$setName set active',
          textAlign: TextAlign.center,
          style: const TextStyle(color: DarkerBlueGrey, fontSize: 16),
        ),
        backgroundColor: getLangSetColour(true),
        behavior: SnackBarBehavior.floating,
        width: 250,
        elevation: 30,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ));
      Timer(const Duration(seconds: 1), () {
        setState(() {
          drawerController.toggleDrawer();
        });
      });
    }
  }

  void searchMatchPreferenceClosed(bool? searchMatchChanged) {
    if (searchMatchChanged ?? false) {
      String matchMethod = matchingMethods[
      UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex];
      if ((UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex) < 4){
        EldamoDb.instance.clearRegexBufferList();
        if (usedRegex){
          clearSearch();
          usedRegex = false;
        }
      }
      _doSearch();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$matchMethod search matching',
          textAlign: TextAlign.center,
          style: const TextStyle(color: DarkerBlueGrey, fontSize: 16),
        ),
        backgroundColor: Ithildin,
        behavior: SnackBarBehavior.floating,
        width: 250,
        elevation: 30,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ));
      Timer(const Duration(seconds: 1), () {
        setState(() {
          drawerController.toggleDrawer();
        });
      });
    }
  }

  Widget _dropDownBuilder(BuildContext context, Language? activeLanguage) {
    return Container(
      child: Text(
        activeLanguage?.name ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: TanteRiaSAvonds, fontWeight: FontWeight.w300, fontSize: 18),
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
        identify: "keyGlossLangSelect",
        keyTarget: keyGlossLangSelect,
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
                          color: Pink),
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
          Size(MediaQuery.of(context).size.width * 0.90,
              MediaQuery.of(context).size.height * 0.15),
          Offset(20.0, MediaQuery.of(context).size.height * 0.27),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: Text(
                      "result list",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w200, color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                    child: Text(
                      "Shows matching entries. Meaning of marks & colours:",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "blue: attested",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: RegularFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "# - cyan: derived from attested",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: DerivedFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "* - green: reconstructed",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: ReconstructedFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "^ - yellow: reformulated",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: ReformulatedFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "? - orange: speculative",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: SpeculativeFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "‽ - red: questioned (by Tolkien)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: QuestionedFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "grey: deprecated",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: StruckOutFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "! - violet: community-created (neo-)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: NeoFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "PINK: WORD ROOTS",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: RootColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Text(
                      "🟫🟫🟫 (background): Poetic / Archaic word",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: RegularFormColour),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: Text(
                      "Tap on a word to see available details.\n"
                      "Terms highlighted in blue in notes and detail rows link to "
                      "further detail screens. "
                      "Author(s) of neo-entries are shown insofar they were "
                      "recorded in Eldamo.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
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
