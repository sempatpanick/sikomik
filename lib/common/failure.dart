import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class Exception extends Failure {
  const Exception(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ResponseFailure extends Failure {
  const ResponseFailure(super.message, {super.statusCode});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
