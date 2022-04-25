import 'package:flutter/material.dart';
import 'package:ithildin/config/user_preferences.dart';

import 'config.dart';

const White = Colors.white;

const BlueTop = const Color(0xFF1D3B7B);
const Ithildin = const Color(0xFFE2FFFE);
const YellowGrey = const Color(0xFF878188);

const SortOfRed = const Color(0xFF876D97);
const IceBlue = const Color(0xFF5B6CA0);
const MountainBlue = const Color(0xFF27466F);
const BlueBottom = const Color(0xFF1F3D58);

const DarkerBlueGrey = const Color(0xFF2E3B41);
const DarkerGreen = const Color(0xFF365250);
const DarkGreen = const Color(0xFF243D34);
const DarkBrown = const Color(0xFF303122);
const MiddleGreen = const Color(0xff4C7F66);
const MiddleBrown = const Color(0xFF505234);
const BlueGrey = const Color(0xFF607D8B);
const PastelIndigo = const Color(0xFF5968B3);
const TanteRia = const Color(0xFF5A7EA5);
const TanteRiaSAvonds = const Color(0xFF364B63);

const LightBlueGrey = const Color(0xFF90B0C0);
const BluerGrey = const Color(0xFF608DAB);
const EarthGrey = const Color(0xff7F7B5E);
const BrightGreen = const Color(0xFF96FDCB);

const DisabledButtons = const Color(0xFFD09090);
const Pink = const Color(0xFFFB9294);
const LightPink = const Color(0xFFFFA2B4);
const BrightBlue = const Color(0xFFACE5EE);
const BrightestBlue = const Color(0xFFC2F5FF);
const Laurelin = const Color(0xFFC0FEE8);
const Telperion = const Color(0xFFFFF7BC);

const LimeAccent = const Color(0xFFEEFF41);

const IndigoColour = const Color(0xFF8080FF); // indigo

const RegularFormColour = const Color (0xFF40C4FF); // blauw
const DerivedFormColour = const Color (0xFF40EFC4); // zeegroen
const ReconstructedFormColour = const Color (0xFF90FF40); // heldergroen
const ReformulatedFormColour = const Color (0xFFFFEF40); // knurriegeel
const SpeculativeFormColour = const Color (0xFFFF9030); // oranje
const QuestionedFormColour = const Color (0xFFFF5050); // rood


const ActiveMinimalSetColour = const Color (0xFFFFC0E0);
const ActiveBasicSetColour = const Color (0xFFFFDFC0);
const ActiveMediumSetColour = const Color (0xFF99FFCC);
const ActiveLargeSetColour = const Color (0xFFBFDFFF);
const ActiveCompleteSetColour = const Color (0xFFDFBFFF);


const InActiveMinimalSetColour = const Color (0xFF7F5F6F);
const InActiveBasicSetColour = const Color (0xFF7F6953);
const InActiveMediumSetColour = const Color (0xFF597F6C);
const InActiveLargeSetColour = const Color (0xFF606F7F);
const InActiveCompleteSetColour = const Color (0xFF6F5F7F);

const LightAnyMatchColour = const Color (0xFFFF3639); // rood
const LightStartMatchColour = const Color (0xFFFF8F21); // oranje
const LightEndMatchColour = const Color (0xFFFFEB19); // groen
const LightVerbatimMatchColour = const Color (0xFF1AFF4F); // blâh
const LightRegexMatchColour = const Color (0xFF1A92FF); // blâh

const DarkAnyMatchColour = const Color (0xFFCB282B); // rood
const DarkStartMatchColour = const Color (0xFFCD7A2A); // oranje
const DarkEndMatchColour = const Color (0xFFCDBE29); // groen
const DarkVerbatimMatchColour = const Color (0xFF28CB4E); // blâh
const DarkRegexMatchColour = const Color (0xFF2A7FCD); // blâh

const NeoFormColour = const Color (0xFFC084FF);
const StruckOutFormColour = const Color (0xFFB0B0B0);


const RegularResultBGColour = const Color(0xFF455A64); // result list BG
const PoeticResultBGColour = const Color(0xFF765645);

const PoeticColour = const Color (0xFFFFA060);
const RootColour = const Color (0xFFFF50B0);

const InvisibleDark = const Color(0x00090F13);
const VeryVeryDark = Color(0xB3090F13);

const OffWhite = Color(0xFFF9F8F9);
const NotepaperWhite = Color(0xFFE6F0E3);
const NotepaperLinked = Color(0xFFE0F0FF);

const DividerColour = Color(0x2F0000F0);
const ThemeTextColour = Color(0xDD000000);
const ThemeTextColour2 = Color(0xFF444444);
const BlueTextColour = Color(0xFF4444FF);

const String CSSText = StartSpan + CSSColText + '; ' + FontLight + EndSpan;
const String CSSBoldMountainBlue = StartSpan + CSSColMountainBlue + '; ' + FontBold + EndSpan;
const String CSSBoldBlueGrey = StartSpan + CSSColBlueGrey + '; ' + FontBolder + EndSpan;
const String CSSBoldVeryBlue = StartSpan + CSSBlueText + '; ' + FontBolder + EndSpan;
const String CSSBoldDisabled = StartSpan + CSSOchre + '; ' + FontBolder + EndSpan;
const String CSSBolder = StartSpan + CSSColText + '; ' + FontBolder + EndSpan;
const String CSSBolderVeryBlue = StartSpan + CSSBlueText + '; ' + FontBolder + EndSpan;
const String CSSGreenItalic = StartSpan + CSSColGreen + '; ' + FontItalic + '; ' + FontNormal + EndSpan;
const String CSSBoldGreen = StartSpan + CSSColGreen + '; ' + FontBold + EndSpan;
const String CSSBlueGreyItalic = StartSpan + CSSColBlueGrey + '; ' + FontItalic + '; ' + FontLight + EndSpan;
const String CSSBoldItalic = StartSpan + CSSColText + '; ' + FontBold + ';' + FontItalic + EndSpan;


const String StartSpan = '<span style="';
const String FontLight = "font-weight:300";
const String FontNormal = "font-weight:400";
const String FontBold = "font-weight:600";
const String FontBolder = "font-weight:800";
const String FontItalic = "font-style:italic";
const String CSSColText = "color:#444444";
const String CSSBlueText = "color:#4444FF";
const String CSSRedText = "color:#442324";
const String CSSYellowText = "color:#443E23";
const String CSSTealText = "color:#23443D";
const String CSSPurpleText = "color:#442341";
const String CSSColGreen = "color:#267F54";
const String CSSColBlueGrey = "color:#264F7F";
const String CSSColMountainBlue = "color:#27466F";
const String CSSOchre = "color:#C0B090";
const String EndSpan = '">';
const String CloseSpan = "</span>";

Color getColourByNumber(int colnr){
  switch(colnr) {
    case 0: {  return isCurrentLangSet(colnr) ? ActiveMinimalSetColour : InActiveLargeSetColour; }
    break;

    case 1: {  return isCurrentLangSet(colnr) ? ActiveBasicSetColour : InActiveLargeSetColour; }
    break;

    case 2: {  return isCurrentLangSet(colnr) ? ActiveMediumSetColour : InActiveLargeSetColour; }
    break;

    case 3: {  return isCurrentLangSet(colnr) ? ActiveLargeSetColour : InActiveLargeSetColour; }
    break;

    default: { return isCurrentLangSet(colnr) ? ActiveCompleteSetColour : InActiveLargeSetColour; }
    break;
  }
}

Color getLangSetColour(bool light){
  switch(UserPreferences.getLanguageSet() ?? defaultLanguageSetIndex) {
    case 0: {  return light ? ActiveMinimalSetColour : InActiveMinimalSetColour; }
    break;

    case 1: {  return light ? ActiveBasicSetColour : InActiveBasicSetColour; }
    break;

    case 2: {  return light ? ActiveMediumSetColour : InActiveMediumSetColour; }
    break;

    case 3: {  return light ? ActiveLargeSetColour : InActiveLargeSetColour; }
    break;

    default: { return light ? ActiveCompleteSetColour : InActiveCompleteSetColour; }
    break;
  }
}


Color getTextColourByNumber(int colnr){
  return isCurrentLangSet(colnr) ? DarkerBlueGrey : NotepaperWhite;
}

bool isCurrentLangSet(int index){
  return (index - (UserPreferences.getLanguageSet() ?? defaultLanguageSetIndex) == 0);
}