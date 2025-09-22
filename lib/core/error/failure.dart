abstract class Failure implements Exception{}

class NetworkFailure extends Failure {}

class AccessDeniedFailure extends Failure{}

class MissedInputFailure extends Failure {}

class AuthorizeFailure extends Failure {}

class DisabledUserFailure extends Failure {}

class NotFoundFailure extends Failure {}

class UnChangeableFailure extends Failure {}

class MustBeUniqueFailure extends Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class PermissionFailure extends Failure {}

class IntentFailure extends Failure {}

class ParseFailure extends Failure {}

class NeedUpdateFailure extends Failure {
  final bool isForce;
  final int latestVersion;

  NeedUpdateFailure(this.isForce, this.latestVersion);
}

class PremiumFailure extends Failure {}

class NotDoneFailure extends Failure {}

class UnknownFailure extends Failure {}
