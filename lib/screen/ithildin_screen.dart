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
  final searchController = TextEditingController();
  final ScrollController controller = ScrollController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keySettingsButton = GlobalKey();
  GlobalKey keyEldarinLangSelect = GlobalKey();
  GlobalKey keyGlossLangSelect = GlobalKey();
  GlobalKey keyFormOrGloss = GlobalKey();
  GlobalKey keySearchField = GlobalKey();
  GlobalKey keyResultList = GlobalKey();

  late List<Language> eldarinLanguageSet;
  late List<Language> glossLanguageSet;
  Language? _activeEldarinLanguage;
  Language? _activeGlossLanguage;

  late List<Simplexicon> simplexicons;

  bool isLanguageDataLoading = false;
  bool isSimplexiconLoading = true;
  bool usedRegex = false;
  int _formOrGloss = 0;

  final double refWidth = 448;
  double toScale = 1;



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

    double toScale = MediaQuery.of(context).size.width / refWidth ;

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
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: VeryVeryDark,
        //     blurRadius: 1.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: RegularResultBGColour,
          automaticallyImplyLeading: true,
          leading: IconButton(
            key: keySettingsButton,
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
            padding: EdgeInsetsDirectional.fromSTEB(10 * toScale, 10 * toScale, 10 * toScale, 10 * toScale),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// top row with two searchable dropdown lists for languages
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10 * toScale),
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 4 * toScale, 0),
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
                                    EdgeInsets.fromLTRB(12 * toScale, 8 * toScale, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: TanteRia),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0 * toScale))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0 * toScale))),
                              ),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: "filter on",
                                  filled: true,
                                  fillColor: getLangSetColour(true),
                                  contentPadding:
                                          EdgeInsets.fromLTRB(12 * toScale, 12 * toScale, 8 * toScale, 0),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: LightBlueGrey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0 * toScale))),
                                ),
                              ),
                              popupTitle: Container(
                                height: 50 * toScale,
                                decoration: BoxDecoration(
                                  color: getLangSetColour(false),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20 * toScale),
                                    topRight: Radius.circular(20 * toScale),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'select Eldarin language',
                                    style: TextStyle(
                                      fontSize: 18 * toScale,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24 * toScale),
                                  topRight: Radius.circular(24 * toScale),
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
                        height: 50 * toScale,
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
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            fillColor: Telperion,
                            hintText: "tap to change",
                            prefixIconColor: DarkBrown,
                            contentPadding: EdgeInsets.fromLTRB(12 * toScale, 8 * toScale, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: TanteRia),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0  * toScale))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0 * toScale))),
                          ),

                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Telperion,
                              labelText: "filter on",
                              contentPadding: EdgeInsets.fromLTRB(12 * toScale, 12 * toScale, 8 * toScale, 0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0 * toScale))),
                            ),
                          ),

                          popupTitle: Container(
                            height: 50 * toScale,
                            decoration: BoxDecoration(
                              color: MiddleBrown,
                              //Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20 * toScale),
                                topRight: Radius.circular(20 * toScale),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'select language',
                                style: TextStyle(
                                  fontSize: 18 * toScale,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          popupShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24 * toScale),
                              topRight: Radius.circular(24 * toScale),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10 * toScale),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        key: keyFormOrGloss,
                        minHeight: 44.0 * toScale,
                        minWidth: 70.0 * toScale,
                        cornerRadius: 15.0 * toScale,
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
                        fontSize: 18 * toScale,

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
                          margin: EdgeInsets.fromLTRB(8 * toScale, 0, 0, 0),
                          height: 50 * toScale,
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
                                .copyWith(color: TanteRiaSAvonds, fontWeight: FontWeight.w300, fontSize: 18 * toScale),
                              controller: searchController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: BrightBlue,
                                  hintText: "Search",
                                  prefixIcon: Icon(
                                    getMatchMethodIcon(),
                                    color: TanteRiaSAvonds,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0 * toScale)))),
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
                            ? Text(
                                'No entries found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14 * toScale),
                              )
                            : DraggableScrollbar.semicircle(
                                alwaysVisibleScrollThumb: false,
                                backgroundColor: DarkerBlueGrey,
                                padding: EdgeInsets.only(right: 4.0 * toScale),
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
                                    style: TextStyle(
                                        color: BrightGreen, fontSize: 14 * toScale),
                                  );
                                },
                                controller: controller,
                                child: ListView.builder(
                                    controller: controller,
                                    key: keyResultList,
                                    itemCount: simplexicons.length,
                                    padding: EdgeInsets.all(4.0 * toScale),
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
                  width: 128.0 * toScale,
                  height: 128.0 * toScale,
                  margin: EdgeInsets.only(
                    top: 24.0 * toScale,
                    bottom: 64.0 * toScale,
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
                      width: 4.0 * toScale,
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
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20 * toScale)),
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
          style: TextStyle(color: DarkerBlueGrey, fontSize: 16 * toScale),
        ),
        backgroundColor: getLangSetColour(true),
        behavior: SnackBarBehavior.floating,
        width: 250 * toScale,
        elevation: 30,
        padding: EdgeInsets.fromLTRB(20 * toScale, 10 * toScale, 20 * toScale, 10 * toScale),
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
          style: TextStyle(color: DarkerBlueGrey, fontSize: 16 * toScale),
        ),
        backgroundColor: Ithildin,
        behavior: SnackBarBehavior.floating,
        width: 250 * toScale,
        elevation: 30,
        padding: EdgeInsets.fromLTRB(20 * toScale, 10 * toScale, 20 * toScale, 10 * toScale),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24 * toScale),
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
            .copyWith(color: TanteRiaSAvonds, fontWeight: FontWeight.w300, fontSize: 18 * toScale),
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
      paddingFocus: 10 * toScale,
      opacityShadow: 0.9,
    )..show();
  }

  void initTargets() {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "keySettingsButton",
        keyTarget: keySettingsButton,
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
                    "Settings",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w200, color: Ithildin),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0 * toScale),
                    child: Text(
                      "Opens a settings menu for: \n\n"
                          "- Language Sets (what languages to have available in the "
                          "Search screen language selector)\n\n"
                          "- Search matching (how search terms should match with "
                          "words, e.g. verbatim, anywhere, or otherwise)\n\n",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0 * toScale),
                    child: Text(
                      "See the screens for details..\n\n",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
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
                    padding: EdgeInsets.only(top: 10.0 * toScale),
                    child: Text(
                      "Shows the current Eldarin language.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
                          color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20 * toScale, 0, 20 * toScale),
                    child: Text(
                      "Tap to select another language from the active Set in the "
                      "pop-up list below.\n\nScroll if the list is too long, or "
                      "filter by typing one or more characters in the field "
                      "marked 'Filter on'.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
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
        radius: 5 * toScale,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20 * toScale, 0, 20 * toScale),
                    child: Text(
                      "(not currently active because only English is available at this time)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
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
        radius: 5 * toScale,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20 * toScale, 0, 20 * toScale),
                    child: Text(
                      "Set to search on forms (Eldarin words) or glosses (their "
                      "translations)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
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
                        child: const Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5 * toScale,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20 * toScale, 0, 20 * toScale),
                    child: Text(
                      "Tap and enter one or more characters to search.\n\n"
                          "How this matches to the search results can be changed "
                          "in the 'Search Matching' settings (available under the "
                          "gear icon top left). See the explanation there about "
                          "the different matching methods.\n\n"
                          "Note that the active matching method is indicated with "
                          "the icon in the search field (e.g. magnifying glass)",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 15 * toScale,
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
                        child: const Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: const Icon(Icons.chevron_right),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5 * toScale),
                    child: Text(
                      "result list",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w200, color: Ithildin),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8 * toScale, 0, 4 * toScale),
                    child: Text(
                      "Shows matching entries. Meaning of marks & colours:",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                          fontSize: 14 * toScale,
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
                        child: const Icon(Icons.chevron_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.next();
                        },
                        child: const Icon(Icons.chevron_right),
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
