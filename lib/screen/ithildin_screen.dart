import 'package:flutter/cupertino.dart';
import 'package:ithildin/db/eldamo_db.dart';
import 'package:ithildin/model/language.dart';
import 'package:ithildin/model/simplexicon.dart';
import 'package:ithildin/screen/slex_list.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../config/config.dart';
import '../config/theme.dart';

class IthildinScreen extends StatefulWidget {
  const IthildinScreen({Key? key}) : super(key: key);

  @override
  _IthildinScreenState createState() => _IthildinScreenState();
}

class _IthildinScreenState extends State<IthildinScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
    print('Searched for: ${searchController.text}');
    // if (searchController.text.length > 1) {
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
        backgroundColor: Colors.blueGrey.shade700,
        automaticallyImplyLeading: true,
        leading: Builder(
          builder: (BuildContext context) {

            return PopupMenuButton<String>(
                elevation: 4,
                icon: Icon(
                  CupertinoIcons.square_stack_3d_down_right,
                  color: BrightGreen,
                  size: 24.0,
                  semanticLabel: 'choose language set',
                ),
                shape: RoundedRectangleBorder(
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
                }
             );
          },
        ),
        title: const Text("Ithildin word search"),
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
                              print(eldarinLang);
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
                          print(modernLang);
                          _glossLangId = modernLang?.id;
                          _doSearch();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleSwitch(

                      minHeight: 44.0,
                      minWidth: 70.0,

                      cornerRadius: 15.0,
                      borderWidth: 1,
                      borderColor: const [Colors.white],
                      dividerColor: Colors.blueGrey,
                      activeBgColors: const [
                        [MiddleGreen],
                        [EarthGrey]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      initialLabelIndex: _formOrGloss,
                      labels: const ['form', 'gloss'],
                      animate: true,
                      // with just animate set to true, default curve = Curves.easeIn
                      curve: Curves.ease,
                      // animat
                      onToggle: (index) {
                        setState(() {
                          _formOrGloss = index!;
                        });
                        _doSearch();
                        print('switched to: $index');
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

              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     Text(
              //       'search glosses',
              //     ),
              //   ],
              // ),
              Expanded(
                  child: isSimplexiconLoading
                      ? const CircularProgressIndicator()
                      : simplexicons.isEmpty
                          ? const Text(
                              'No entries found',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          : ListView.builder(
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
                                );
                              })),
            ],
          ),
        ),
      ),
    );
  }
}
