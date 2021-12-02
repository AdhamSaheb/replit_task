import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:replit/Constants/editor_theme.dart';

// Code Snipper Editor Widget
class Editor extends StatefulWidget {
  final TextEditingController controller;
  const Editor({Key? key, required this.controller}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  String code = '';

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
              fontFamilyFallback: ['Ubuntu'],
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 10000,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: TextField(
            controller: widget.controller,
            maxLines: null,
            style: const TextStyle(color: Colors.transparent, fontSize: 15),
            cursorColor: Colors.white,
            onChanged: (val) => setState(() {
              code = widget.controller.text;
            }),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ]),
    );
  }
}



// dynamic doSomething(String? language, String? value) {
//   print('submitted');
// }
