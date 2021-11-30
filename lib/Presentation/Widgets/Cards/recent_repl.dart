import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:replit/Data/Models/recent_repl.dart';
import 'package:replit/Presentation/Pages/repl.dart';

// Recent Repl Card
class RecentReplCard extends StatelessWidget {
  final RecentRepl repl;
  const RecentReplCard({Key? key, required this.repl}) : super(key: key);

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
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: lightGreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repl.title,
                style: bold.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    repl.langaugeLogoPath,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    repl.lastUpdated,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
