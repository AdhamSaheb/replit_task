import 'package:flutter/material.dart';
import 'package:replit/Constants/textStyles.dart';

class Console extends StatefulWidget {
  // Run Code Results
  final String content;
  const Console({Key? key, required this.content}) : super(key: key);

  @override
  _ConsoleState createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Terminal",
            style: bold.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Ubuntu',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$ py main.py\n',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontFamily: 'Ubuntu',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '>>> ' + widget.content,
                style: const TextStyle(
                    color: Colors.white, fontSize: 13, fontFamily: 'Ubuntu'),
                textAlign: TextAlign.left,
              ),
            ],
          )
        ],
      ),
    );
  }
}
