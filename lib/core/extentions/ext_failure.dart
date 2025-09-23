import 'package:flutter/material.dart';

import '/generated/i18n.dart';
import '/core/error/failure.dart';

extension ErrorMessageHandlerImpl on Failure {
  String message(BuildContext context) {
    if (this is NetworkFailure) {
      return S.of(context).error_internet_connection;
    } else if (this is DisabledUserFailure) {
      return S.of(context).error_disabled_user;
    } else if (this is AccessDeniedFailure) {
      return S.of(context).error_access_denied;
    } else if (this is MissedInputFailure) {
      return S.of(context).error_missed_input;
    } else if (this is NotFoundFailure) {
      return S.of(context).error_not_found;
    } else if (this is UnknownFailure) {
      return S.of(context).error_unknown;
    } else if (this is CacheFailure) {
      return S.of(context).error_cache;
    } else if (this is ServerFailure) {
      return S.of(context).error_server;
    } else if (this is IntentFailure) {
      return S.of(context).error_intent;
    } else if (this is PermissionFailure) {
      return S.of(context).error_permission;
    } else if (this is ParseFailure) {
      return S.of(context).error_parse;
    } else if (this is NotDoneFailure) {
      return S.of(context).error_not_done;
    } else {
      return toString();
    }
  }
}