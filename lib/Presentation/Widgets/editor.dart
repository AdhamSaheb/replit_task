import 'package:flutter/material.dart';
import 'package:code_editor/code_editor.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/editor_theme.dart';

// Code Snipper Editor Widget
class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  // Editor controller
  EditorModel model = EditorModel(
    files: [
      FileEditor(name: "main.py", language: "python", code: ''' 
from os import path

def check_for_file():
    print("Does file exist:", path.exists("data.csv"))

if __name__=="__main__":
    check_for_file()'''),
    ], // the files created above
    // style customization
    styleOptions: EditorModelStyleOptions(
        theme: myEditorTheme,
        fontSize: 13,
        heightOfContainer: 700,
        editorColor: darkGreen,
        fontFamily: "monospace",
        editorToolButtonColor: lightGreen,
        editButtonBackgroundColor: lightGreen,
        editButtonTextColor: Colors.white,
        // Toolbar
        toolbarOptions: const ToolbarOptions(
            copy: true, cut: true, paste: true, selectAll: true),
        editButtonName: 'Modify',
        textStyleOfTextField: editorTextFieldStyle),
  );

  EditorModelStyleOptions ops = EditorModelStyleOptions();

  @override
  void initState() {
    super.initState();
    model.styleOptions?.defineEditButtonPosition(top: 5.0, right: 5.0);
  }

  // A custom TextEditingController.
  final myController = TextEditingController(text: 'hello!');
  @override
  Widget build(BuildContext context) {
    return CodeEditor(
      model: model,
      edit: true,
      disableNavigationbar: true, // hide the navigation bar ? by default false
      onSubmit: doSomething,
      textEditingController: myController, // optional
    );
  }
}

dynamic doSomething(String? language, String? value) {
  print('submitted');
}
