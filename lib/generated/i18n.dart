// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    final localization = Localizations.of<S>(context, S);
    
    assert(() {
      if (localization == null) {
        throw FlutterError(
            'S requested with a context that does not include S.');
      }
      return true;
    }());
    
    return localization!;
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get app_name {
    return Intl.message("Test Movie", name: 'app_name');
  }

  String get movie_list_toolbar {
    return Intl.message("Movie List", name: 'movie_list_toolbar');
  }

  String get movie_info_toolbar {
    return Intl.message("Movie Info", name: 'movie_info_toolbar');
  }

  String get btn_search {
    return Intl.message("Search", name: 'btn_search');
  }

  String get error_internet_connection {
    return Intl.message("No Network Connection!", name: 'error_internet_connection');
  }

  String get error_disabled_user {
    return Intl.message("User is not enable!", name: 'error_disabled_user');
  }

  String get error_access_denied {
    return Intl.message("Access Denied!", name: 'error_access_denied');
  }

  String get error_missed_input {
    return Intl.message("Missed Input!", name: 'error_missed_input');
  }

  String get error_authorization {
    return Intl.message("Not Authorized!", name: 'error_authorization');
  }

  String get error_not_found {
    return Intl.message("Not Found!", name: 'error_not_found');
  }

  String get error_unknown {
    return Intl.message("Unknown Error!", name: 'error_unknown');
  }

  String get error_cache {
    return Intl.message("Read Cash Error!", name: 'error_cache');
  }

  String get error_server {
    return Intl.message("Internal Server Error!", name: 'error_server');
  }

  String get error_intent {
    return Intl.message("Intent Error!", name: 'error_intent');
  }

  String get error_parse {
    return Intl.message("Parse Data Error!", name: 'error_parse');
  }

  String get error_permission {
    return Intl.message("Permission Error!", name: 'error_permission');
  }

  String get error_not_done {
    return Intl.message("Request can not handle, please retry later!", name: 'error_not_done');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale? fallback}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale? locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
