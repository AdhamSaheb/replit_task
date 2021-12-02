import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/logos.dart';
import 'package:replit/Constants/people.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:replit/Constants/toast.dart';
import 'package:replit/Presentation/Widgets/console.dart';
import 'package:replit/Presentation/Widgets/editor.dart';
import 'package:replit/Presentation/Widgets/editor_action_button.dart';
import 'package:replit/Presentation/Widgets/loading.dart';
import 'package:replit/Utils/text_field_utils.dart';

import 'bloc/repl_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Repl extends StatefulWidget {
  const Repl({Key? key}) : super(key: key);

  @override
  _ReplState createState() => _ReplState();
}

class _ReplState extends State<Repl> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController editorController = TextEditingController();
    return BlocProvider(
      create: (context) => ReplBloc(),
      child: SafeArea(
          child: BlocListener<ReplBloc, ReplState>(
        listener: (context, state) async {
          // Open console if run result is not empty
          if (state is ReplLoaded && state.runResult.isNotEmpty) {
            await Future.delayed(
                const Duration(milliseconds: 200),
                () => {
                      BlocProvider.of<ReplBloc>(context)
                          .add(OpenConsole(key: _key))
                    });
          }
        },
        child: BlocBuilder<ReplBloc, ReplState>(
          builder: (context, state) {
            if (state is ReplInitial) {
              BlocProvider.of<ReplBloc>(context).add(LoadFromLocalStorage());
            }
            // Loading State UI
            if (state is ReplLoading) {
              return const Scaffold(
                  backgroundColor: darkGreen, body: Loading());
            }
            // Loaded State UI
            if (state is ReplLoaded) {
              editorController.text = state.code;
              // Move cursor to the end of code
              placeCursorAtTheEnd(editorController);
              return Scaffold(
                key: _key,
                backgroundColor: darkGreen,
                endDrawer: Drawer(
                    child: Console(
                  content: state.runResult,
                )),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Menu(),
                    // Header
                    Header(
                        width: width,
                        controller: editorController,
                        scaffoldKey: _key),
                    // Editor
                    Expanded(
                        child: Editor(
                      controller: editorController,
                      onSlide: () => _key.currentState?.openEndDrawer(),
                    )),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      )),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.width,
    required this.controller,
    required this.scaffoldKey,
  }) : super(key: key);

  final double width;
  final TextEditingController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lightGreen,
          border: Border.all(color: Colors.white, width: 0.5)),
      child: Row(
        children: [
          EditorActionButton(
              width: width / 3 - 1,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "main.py",
                    style: regularWhite.copyWith(fontSize: 15),
                  ),
                  Image.asset(
                    pythonLogo,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              onTap: () => {}),
          // Download
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
              onTap: () => {showFeatureNotAvailableToast()}),

          // Scan
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onTap: () => {showFeatureNotAvailableToast()}),
          // Save
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onTap: () => {
                    BlocProvider.of<ReplBloc>(context)
                        .add(SaveCodeToLocalStorage(code: controller.text))
                  }),
          // Run
          EditorActionButton(
              width: width / 6,
              content: Container(
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
              ),
              onTap: () => {
                    if (controller.text.isNotEmpty)
                      {
                        BlocProvider.of<ReplBloc>(context)
                            .add(SubmitCode(code: controller.text))
                      }
                    else
                      {showValidationToast('Code Cannot Be Empty')}
                  }),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      color: lightGreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: const Icon(Icons.menu, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: 80,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        person1,
                        width: 50,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        person2,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
