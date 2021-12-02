import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/editor_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Code Snipper Editor Widget
class Editor extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSlide;
  const Editor({
    Key? key,
    required this.controller,
    required this.onSlide,
  }) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        SizedBox(
          width: double.infinity,
          child: HighlightView(
            widget.controller.text,
            language: 'python',
            theme: myEditorTheme,
            padding: const EdgeInsets.all(12),
            textStyle: const TextStyle(
              fontFamily: 'My awesome monospace font',
              fontSize: 15,
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 1000,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: TextField(
            controller: widget.controller,
            maxLines: null,
            style: const TextStyle(
                color: Colors.transparent,
                fontSize: 15,
                fontFamily: 'My awesome monospace font'),
            cursorColor: Colors.white,
            onChanged: (val) => setState(() {}),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.multiline,
          ),
        ),
        // open console button
        Positioned(right: 0.0, top: 200, child: ConsoleArrow(widget: widget))
      ]),
    );
  }
}

class ConsoleArrow extends StatelessWidget {
  const ConsoleArrow({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Editor widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSlide,
      child: Container(
          height: 50,
          width: 30,
          decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border.all(color: Colors.white)),
          child: const Center(
              child: FaIcon(FontAwesomeIcons.fileAlt,
                  size: 15, color: Colors.white))),
    );
  }
}
