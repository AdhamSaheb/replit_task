import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';

class EditorActionButton extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final Widget content;

  const EditorActionButton(
      {Key? key,
      required this.width,
      required this.content,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: width,
          child: Center(child: content),
          decoration: const BoxDecoration(
            color: lightGreen,
            border: Border(
              right: BorderSide(width: 1, color: Colors.white),
            ),
          ),
        ));
  }
}
