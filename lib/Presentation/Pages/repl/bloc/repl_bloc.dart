import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Data/Data%20Sources/Local/python_local_storage.dart';
import 'package:replit/Data/Data%20Sources/Remote/python_data_source.dart';
import 'package:replit/Data/Repositories/python_repo_impl.dart';
import 'package:replit/Domain/Repositories/python_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

part 'repl_state.dart';
part 'repl_event.dart';

class ReplBloc extends Bloc<ReplEvent, ReplState> {
  // Handle all events in Repl Page
  ReplBloc() : super(ReplInitial()) {
    // Load code from local storage
    on<LoadFromLocalStorage>((event, emit) async {
      // Show loading indicator
      emit(ReplLoading());
      try {
        String? code = await _localStorageDataSource.fetchSavedCode();
        if (code != null) {
          emit(ReplLoaded(code: code, runResult: ''));
          showSuccessToast('Previous Code Loaded');
        } else {
          emit(ReplLoaded(code: '', runResult: ''));
        }
      } catch (e) {
        emit(ReplLoaded(code: '', runResult: ''));
      }
    });

    // On save
    on<SaveCodeToLocalStorage>((event, emit) async {
      try {
        _localStorageDataSource.saveCode(event.code);
        showSuccessToast('Code Saved');
      } catch (e) {
        emit(ReplLoaded(code: '', runResult: ''));
        showFailureToast('Code Save Failed');
      }
    });

    // On code submit
    on<SubmitCode>((event, emit) async {
      // Show loading indicator
      emit(ReplLoading());
      log(event.code);
      try {
        // Send Request
        Response res = await _pythonRepo.submitPythonCode(event.code);
        // OK
        if (res.statusCode == 200) {
          emit(ReplLoaded(
              code: event.code, runResult: jsonDecode(res.body)?['result']));
        }
        // error
        else {
          emit(ReplLoaded(code: event.code, runResult: ''));
          showFailureToast('Server Error');
        }
      } catch (e) {
        emit(ReplLoaded(code: event.code, runResult: ''));
        showFailureToast('Unknown Error');
      }
    });

    // On Open console
    on<OpenConsole>((event, emit) async {
      event.key.currentState?.openEndDrawer();
    });
  }

  void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: lightGreen,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  void showFailureToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  //Remote Repo
  final PythonRepo _pythonRepo =
      PythonRepoImpl(pythonDataSource: PythonDataSource());
  // Local Repo
  final PythonLocalStorageDataSource _localStorageDataSource =
      PythonLocalStorageDataSource();
}
