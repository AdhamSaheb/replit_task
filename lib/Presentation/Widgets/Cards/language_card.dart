// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:replit/Data/Models/language.dart';
import 'package:replit/Presentation/Pages/repl.dart';

/// Card of a new Repl
class LanguageCard extends StatelessWidget {
  final Language language;
  const LanguageCard({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Repl()),
        )
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: lightPurple.withOpacity(0.1),
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                language.logoPath,
                width: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                language.title,
                style: bold.copyWith(fontSize: 15, color: lightPurple),
              )
            ],
          ),
        ),
      ),
    );
  }
}
