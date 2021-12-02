import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/logos.dart';
import 'package:replit/Constants/people.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:replit/Presentation/Widgets/console.dart';
import 'package:replit/Presentation/Widgets/editor.dart';
import 'package:replit/Presentation/Widgets/editor_action_button.dart';

class Repl extends StatefulWidget {
  const Repl({Key? key}) : super(key: key);

  @override
  _ReplState createState() => _ReplState();
}

class _ReplState extends State<Repl> {
  TextEditingController editorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkGreen,
        endDrawer: const Drawer(
            child: Console(
          content: "",
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Menu(),
            // Header
            Header(width: width),
            // Editor
            Expanded(
                child: Editor(
              controller: editorController,
            ))
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

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
          // Save
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onTap: () => {}),
          // Scan
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onTap: () => {}),
          // Download
          EditorActionButton(
              width: width / 6,
              content: const Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
              onTap: () => {}),
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
              onTap: () => {}),
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
