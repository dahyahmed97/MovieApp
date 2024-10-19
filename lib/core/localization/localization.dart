
import 'dart:convert';

 //import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  /// This is only true in case we are testing.
  static bool _loadedLocally = false;

  /// This is only used in case we are testing and is coupled to [setLocalizedStrings] and [_loadedLocally].
  static Map<String, String> _localLocalizedStrings = {};

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static AppLocalizations? get instance => _AppLocalizationsDelegate.instance;
  Locale locale;

  set seLocal(Locale locale) {
    this.locale = locale;
  }

  Map<String, String> _localizedStrings = {};

  _fetchRemoteTranslation() async {
     try {
       //DocumentSnapshot snapshot = await FirebaseFirestore.instance
         //.collection('localization')
       //.doc(locale.languageCode)
    // .get();
    //_remoteTranslation = snapshot.data() as Map<String, dynamic>;
    } catch (_) {
    _remoteTranslation = {};
     }
  }

  _fetchLocalTranslation() async {
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    _localTranslation = json.decode(jsonString);
  }

  // ignore: unused_field
  Map<String, dynamic> _remoteTranslation = {};
  Map<String, dynamic> _localTranslation = {};
  String jsonString = '';

  Future<void> load() async {
    if (!_loadedLocally) {
      await Future.wait(<Future>[

        _fetchRemoteTranslation(),
      ]);

       _localTranslation.addAll(_remoteTranslation);
      _localizedStrings = _localTranslation.map((key, value) {
        return MapEntry(key, value.toString().replaceAll('\\n', '\n'));
      });
    } else {
      _fetchLocalTranslation();
      _localizedStrings = _localTranslation.map((key, value) {
        return MapEntry(key, value.toString().replaceAll('\\n', '\n'));
      });
      _localizedStrings = _localLocalizedStrings;
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  /// [key] is the same as [translate]
  /// [from] is the key you added in the .json file (gets added to the [strings.dart] file)
  /// [to] is the replacing value to the templated key ([from])
  String translateReplacing(String key,
      {required String from, required String to}) {
    return (_localizedStrings[key] ?? '').replaceAll("{$from}", to);
  }

  @visibleForTesting
  static void setLocalizedStrings(Map<String, String> strings) {
    _loadedLocally = true;
    _localLocalizedStrings = strings;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  _AppLocalizationsDelegate();

  Locale? currentLocale;

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == "ar" || locale.languageCode == "en";
  }

  static AppLocalizations? instance;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    instance = localizations;
    currentLocale = locale;
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
