import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/editor_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:replit/Constants/toast.dart';
import 'package:replit/Constants/toolButton.dart';
import 'package:replit/Utils/text_field_utils.dart';

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
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    /// Add a particular string where the cursor is in the text field.
    /// * [str] the string to insert
    /// * [diff] by default, the the cursor is placed after the string placed, but you can change this (Exemple: -1 for "" placed)
    void insertIntoTextField(
        String str, TextEditingController editingController,
        {int diff = 0}) {
      // get the position of the cursor in the text field
      int pos = editingController.selection.baseOffset;
      // get the current text of the text field
      String baseText = editingController.text;
      // get the string : 0 -> pos of the current text and add the wanted string
      String begin = baseText.substring(0, pos) + str;
      // if we are already in the end of the string
      if (baseText.length == pos) {
        editingController.text = begin;
      } else {
        // get the end of the string and update the text of the text field
        String end = baseText.substring(pos, baseText.length);
        editingController.text = begin + end;
      }
      // Copy changes to syntax highligher
      setState(() {
        value = widget.controller.text;
      });

      placeCursor(pos + str.length + diff, editingController);
    }

    // Function to build the toolbar
    Widget toolBar(TextEditingController controller) {
      List<ToolButton> toolButtons = [
        ToolButton(
          press: () => insertIntoTextField("    ", widget.controller),
          icon: FontAwesomeIcons.indent,
        ),
        ToolButton(
          press: () => {insertIntoTextField("<", widget.controller)},
          icon: FontAwesomeIcons.chevronLeft,
        ),
        ToolButton(
          press: () => insertIntoTextField(">", widget.controller),
          icon: FontAwesomeIcons.chevronRight,
        ),
        ToolButton(
          press: () => insertIntoTextField('""', widget.controller, diff: -1),
          icon: FontAwesomeIcons.quoteLeft,
        ),
        ToolButton(
          press: () => insertIntoTextField(":", widget.controller),
          symbol: ":",
        ),
        ToolButton(
          press: () => insertIntoTextField(";", widget.controller),
          symbol: ";",
        ),
        ToolButton(
          press: () => insertIntoTextField('()', widget.controller, diff: -1),
          symbol: "()",
        ),
        ToolButton(
          press: () => insertIntoTextField('{}', widget.controller, diff: -1),
          symbol: "{}",
        ),
        ToolButton(
          press: () => insertIntoTextField('[]', widget.controller, diff: -1),
          symbol: "[]",
        ),
        ToolButton(
          press: () => insertIntoTextField(
            "-",
            widget.controller,
          ),
          icon: FontAwesomeIcons.minus,
        ),
        ToolButton(
          press: () => insertIntoTextField("=", widget.controller),
          icon: FontAwesomeIcons.equals,
        ),
        ToolButton(
          press: () => insertIntoTextField("+", widget.controller),
          icon: FontAwesomeIcons.plus,
        ),
        ToolButton(
          press: () => insertIntoTextField("/", widget.controller),
          icon: FontAwesomeIcons.divide,
        ),
        ToolButton(
          press: () => insertIntoTextField("*", widget.controller),
          icon: FontAwesomeIcons.times,
        ),
        ToolButton(
            press: () => showFeatureNotAvailableToast(),
            icon: FontAwesomeIcons.copy),
        ToolButton(
            press: () => showFeatureNotAvailableToast(),
            icon: FontAwesomeIcons.paste),
      ];

      // Building the Editor
      return Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: lightGreen,
          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          itemCount: toolButtons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            final ToolButton btn = toolButtons[index];

            return Container(
              width: 55,
              margin: const EdgeInsets.only(right: 15),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: lightGreen,
                ),
                onPressed: btn.press as void Function()?,
                child: btn.icon == null
                    ? Text(
                        btn.symbol ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "monospace",
                        ),
                      )
                    : FaIcon(
                        btn.icon,
                        color: Colors.white,
                        size: 15,
                      ),
              ),
            );
          },
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          toolBar(widget.controller),
          Stack(children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: SizedBox(
                width: double.infinity,
                child: HighlightView(
                  value!,
                  language: 'python',
                  theme: myEditorTheme,
                  padding: const EdgeInsets.all(12),
                  textStyle: const TextStyle(
                    fontFamily: 'My awesome monospace font',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                color: Colors.transparent,
                height: 10000,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: TextField(
                  controller: widget.controller,
                  maxLines: null,
                  style: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 15,
                      fontFamily: 'My awesome monospace font'),
                  cursorColor: Colors.white,
                  onChanged: (val) => setState(() {
                    value = val;
                  }),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            // open console button
            Positioned(
                right: 0.0, top: 200, child: ConsoleArrow(widget: widget)),
            Positioned(
                left: 0.0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 12),
                  color: lightGreen,
                  height: 10000,
                  width: 50,
                  child: ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1000,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Column(
                          children: [
                            Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                  color: Colors.white, letterSpacing: 1.5),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 2,
                            )
                          ],
                        );
                      }),
                )),
          ]),
        ],
      ),
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
