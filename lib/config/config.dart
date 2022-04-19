import 'package:ithildin/config/user_preferences.dart';
import 'package:flutter/cupertino.dart';

// ID values from LANGUAGE table
const int allLanguages = 1;
const int pElvish = 30;
const int quenya = 3000;
const int sindarin = 30120;
const int neoPElvish = 20;
const int neoQuenya = 21;
const int neoSindarin = 22;
const int pElvishInclNeo = 7;
const int quenyaInclNeo = 8;
const int sindarinIncNeo = 9;

// start indexes for ithildin_screen
const int defaultEldarinLangId = 30120; // ID of Sindarin
const int defaultGlossLangId = 100; // ID of English
const int defaultLanguageSetIndex = 2;
const int defaultMatchingMethodIndex = 0;

var langCategories = <String>[
  'minimal',
  'basic',
  'medium',
  'large',
  'complete',
];

var matchingMethods = <String>[
  'anywhere',
  'start',
  'end',
  'verbatim',
  'regex',
];

List<IconData> matchIcons = [
  CupertinoIcons.search,
  CupertinoIcons.arrow_left_to_line,
  CupertinoIcons.arrow_right_to_line,
  CupertinoIcons.equal,
  CupertinoIcons.ellipsis,
];

IconData getMatchMethodIcon(){
  return matchIcons[(UserPreferences.getMatchMethod() ?? defaultMatchingMethodIndex)];
}

//
// CupertinoIcons.search_circle
// CupertinoIcons.arrow_left_circle
// CupertinoIcons.arrow_right_circle
// CupertinoIcons.equal_circle
// CupertinoIcons.ellipsis_circle