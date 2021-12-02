part of 'repl_bloc.dart';

abstract class ReplState {}

class ReplInitial extends ReplState {}

class ReplLoading extends ReplState {
  @override
  String toString() {
    return 'ReplLoading';
  }
}

class ReplLoaded extends ReplState {
  final String code;
  final String runResult;

  ReplLoaded({required this.code, required this.runResult});

  @override
  String toString() {
    return 'ReplLoaded';
  }
}

class ReplFailed extends ReplState {
  final String errorMessage;

  ReplFailed({required this.errorMessage});

  @override
  String toString() {
    return 'ReplFailed';
  }
}
