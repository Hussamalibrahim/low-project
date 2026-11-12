abstract class Failure {
  final String message;
  final dynamic error;

  const Failure(this.message, [this.error]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          error == other.error;

  @override
  int get hashCode => Object.hash(message, error);

  @override
  String toString() => '$runtimeType: $message${error != null ? " ($error)" : ""}';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.error]);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, [super.error]);
}

class SecurityFailure extends Failure {
  const SecurityFailure(super.message, [super.error]);
}

class BackupFailure extends Failure {
  const BackupFailure(super.message, [super.error]);
}

class AiFailure extends Failure {
  const AiFailure(super.message, [super.error]);
}

class SpeechFailure extends Failure {
  const SpeechFailure(super.message, [super.error]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.error]);
}
