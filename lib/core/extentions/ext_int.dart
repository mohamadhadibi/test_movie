import 'package:test_movie/core/error/failure.dart';

extension ExtIntNullable on int? {
  Exception get exception {
    if (this != null) {
      switch (this) {
        case 400:
          return MissedInputFailure();
        case 401:
          return AuthorizeFailure();
        case 403:
          return AccessDeniedFailure();
        case 404:
          return NotFoundFailure();
        case 422:
          return UnChangeableFailure();
        case 423:
          return MustBeUniqueFailure();
        case 500:
        case 501:
        case 503:
          return ServerFailure();
        default:
          return UnknownFailure();
      }
    } else {
      return UnknownFailure();
    }
  }
}