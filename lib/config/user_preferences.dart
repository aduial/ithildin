import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyLanguageSet = 'languageSet';
  static const _keyActiveEldarinLangId = 'activeEldarinLangId';
  static const _keyActiveGlossLangId = 'activeGlossLangId';
  static const _keyMatchMethod = 'matchMethod';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLanguageSet(int languageSet) async =>
      await _preferences?.setInt(_keyLanguageSet, languageSet);

  static Future setActiveEldarinLangId(int activeEldarinLangId) async =>
      await _preferences?.setInt(_keyActiveEldarinLangId, activeEldarinLangId);

  static Future setActiveGlossLangId(int activeGlossLangId) async =>
      await _preferences?.setInt(_keyActiveGlossLangId, activeGlossLangId);

  static Future setMatchMethod(int matchMethod) async =>
      await _preferences?.setInt(_keyMatchMethod, matchMethod);


  static int? getLanguageSet() => _preferences?.getInt(_keyLanguageSet);

  static int? getActiveEldarinLangId() => _preferences?.getInt(_keyActiveEldarinLangId);

  static int? getActiveGlossLangId() => _preferences?.getInt(_keyActiveGlossLangId);

  static int? getMatchMethod() => _preferences?.getInt(_keyMatchMethod);

}