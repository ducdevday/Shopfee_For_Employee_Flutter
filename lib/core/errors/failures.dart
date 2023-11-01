import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  Failure({this.message = ""});

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final bool isNotLoaded;

  ServerFailure({
    super.message,
    this.isNotLoaded = false,
  });
}

class NetworkFailure extends Failure {
  NetworkFailure(
      {message = "No internet connection. Please check your network."});
}

class UnknownFailure extends Failure {
  UnknownFailure({message = "Something went wrong. Please try again"});
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure({super.message});
}
