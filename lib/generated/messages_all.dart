// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"app_name" : MessageLookupByLibrary.simpleMessage("Test Movie"),
		"movie_list_toolbar" : MessageLookupByLibrary.simpleMessage("Movie List"),
		"movie_favorites_toolbar" : MessageLookupByLibrary.simpleMessage("Favorites"),
		"btn_search" : MessageLookupByLibrary.simpleMessage("Search"),
		"error_internet_connection" : MessageLookupByLibrary.simpleMessage("No Network Connection!"),
		"error_disabled_user" : MessageLookupByLibrary.simpleMessage("User is not enable!"),
		"error_access_denied" : MessageLookupByLibrary.simpleMessage("Access Denied!"),
		"error_missed_input" : MessageLookupByLibrary.simpleMessage("Missed Input!"),
		"error_authorization" : MessageLookupByLibrary.simpleMessage("Not Authorized!"),
		"error_not_found" : MessageLookupByLibrary.simpleMessage("Not Found!"),
		"error_unknown" : MessageLookupByLibrary.simpleMessage("Unknown Error!"),
		"error_cache" : MessageLookupByLibrary.simpleMessage("Read Cash Error!"),
		"error_server" : MessageLookupByLibrary.simpleMessage("Internal Server Error!"),
		"error_intent" : MessageLookupByLibrary.simpleMessage("Intent Error!"),
		"error_parse" : MessageLookupByLibrary.simpleMessage("Parse Data Error!"),
		"error_permission" : MessageLookupByLibrary.simpleMessage("Permission Error!"),
		"error_not_done" : MessageLookupByLibrary.simpleMessage("Request can not handle, please retry later!"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"en": () => Future.value(null),

};

MessageLookupByLibrary? _findExact(localeName) {
  switch (localeName) {
    case "en":
        return _$en;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
