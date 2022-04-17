import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyLanguageSet = 'languageSet';
  static const _keyActiveEldarinLangId = 'activeEldarinLangId';
  static const _keyActiveGlossLangId = 'activeGlossLangId';
  static const _keySearchMethod = 'searchMethod';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLanguageSet(int languageSet) async =>
      await _preferences?.setInt(_keyLanguageSet, languageSet);

  static Future setActiveEldarinLangId(int activeEldarinLangId) async =>
      await _preferences?.setInt(_keyActiveEldarinLangId, activeEldarinLangId);

  static Future setActiveGlossLangId(int activeGlossLangId) async =>
      await _preferences?.setInt(_keyActiveGlossLangId, activeGlossLangId);

  static Future setSearchMethod(int searchMethod) async =>
      await _preferences?.setInt(_keySearchMethod, searchMethod);


  static int? getLanguageSet() => _preferences?.getInt(_keyLanguageSet);

  static int? getActiveEldarinLangId() => _preferences?.getInt(_keyActiveEldarinLangId);

  static int? getActiveGlossLangId() => _preferences?.getInt(_keyActiveGlossLangId);

  static int? getSearchMethod() => _preferences?.getInt(_keySearchMethod);

}