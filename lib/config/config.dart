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
const int eldarinStartIndex = 1;
const int modernStartIndex = 0;


var langCategories = <String>[
  'minimal',
  'basic',
  'medium',
  'large',
  'complete',
];

Map<String, String> catMap = {
  'minimal': '< 1',
  'basic': '< 2',
  'medium': '< 3',
  'large': '< 4',
  'complete': '< 5',
};
