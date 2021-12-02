import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:replit/Data/Data%20Sources/Remote/python_data_source.dart';
import 'package:replit/Data/Repositories/python_repo_impl.dart';
import 'package:replit/Domain/Repositories/python_repo.dart';

part 'repl_state.dart';
part 'repl_event.dart';

class ReplBloc extends Bloc<ReplEvent, ReplState> {
  ReplBloc() : super(ReplInitial());

  //Remote Repo
  final PythonRepo _pythonRepo =
      PythonRepoImpl(pythonDataSource: PythonDataSource());

  Stream<ReplState> mapEventToState(
    ReplEvent event,
  ) async* {
    if (event is LoadFromLocalStorage) {
      yield ReplLoading();
      // mock load
      await Future.delayed(const Duration(milliseconds: 500), () {});
      // loaded
      yield ReplLoaded(code: 'code', runResult: 'ruesult');
    }
    if (event is SaveCodeToLocalStorage) {
      yield ReplLoading();
      // mock load
      await Future.delayed(const Duration(milliseconds: 500), () {});
      // loaded
      yield ReplLoaded(code: 'code', runResult: 'ruesult');
    }
    if (event is SubmitCode) {
      yield ReplLoading();
      // mock load
      await Future.delayed(const Duration(milliseconds: 500), () {});
      // loaded
      yield ReplLoaded(code: 'code', runResult: 'ruesult');
    }
  }
}
