import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization{
  final Locale locale;
  AppLocalization(this.locale);
  static AppLocalization of(BuildContext context){

    return Localizations.of(context, AppLocalization);
  }


  Map<String,String>? _localizedValues;

  Future loadJson() async{

    String jsonStringValues = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String , dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));

  }
  String? getTranslatedValues(String key){
    return _localizedValues![key];
  }

  static  LocalizationsDelegate <AppLocalization> delegate =  _ApplocalizationDelegate();
}

class _ApplocalizationDelegate extends LocalizationsDelegate<AppLocalization> {

 const _ApplocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
   AppLocalization localization = AppLocalization(locale);
   await localization.loadJson();
   return localization;

  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}