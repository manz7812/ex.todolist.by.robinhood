import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class DataNotFound extends Failure {
  const DataNotFound(String message) : super(message);
}

class CoreNetworkFailure extends Failure {
  final int? statusCode;
  const CoreNetworkFailure(super.message, this.statusCode);
}