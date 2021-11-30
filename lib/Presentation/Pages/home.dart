// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/languages.dart';
import 'package:replit/Constants/logos.dart';
import 'package:replit/Constants/recent_repls.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:replit/Data/Data%20Sources/Remote/python_data_source.dart';
import 'package:replit/Presentation/Widgets/Cards/language_card.dart';
import 'package:replit/Presentation/Widgets/Cards/recent_repl.dart';
import 'package:replit/Presentation/Widgets/navigation_title.dart';

/// First Page Of the Application
class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);

  @override
  HomeComponentState createState() => HomeComponentState();
}

class HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // the main sections of the home page
              children: [
                const HomeHeader(),
                const SizedBox(height: 20),
                // Recent Repls
                NavigationTitle(
                  title: "Recents",
                  onTap: () => {},
                  child: const RecentRepls(),
                ),
                // Create New Repl
                NavigationTitle(
                  title: "Create",
                  onTap: () => {},
                  child: const CreateRepl(),
                  //child: Container(),
                ),
                //GitHub Repos
                NavigationTitle(
                  title: "GitHub Repos",
                  onTap: () => {},
                  child: GithubButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The hamburger menu and the title at the top of the page
class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.menu_sharp,
            color: lightGreen,
          ),
          SizedBox(width: width / 3.9),
          Image.asset(replitLogo)
        ],
      ),
    );
  }
}

/// Recent Repls Child View
class RecentRepls extends StatelessWidget {
  const RecentRepls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: recentRepls.length,
          itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RecentReplCard(repl: recentRepls[index]),
              )),
    );
  }
}

/// Create new Repl Child View
class CreateRepl extends StatelessWidget {
  const CreateRepl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appLanguages.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: LanguageCard(
            language: appLanguages[index],
          ),
        ),
      ),
    );
  }
}

/// Connect to GitHub Child View
class GithubButton extends StatelessWidget {
  GithubButton({Key? key}) : super(key: key);
  final PythonDataSource pythonDataSource = PythonDataSource();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: lightPurple.withOpacity(0.8),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              github,
              width: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Connect GitHub Repo",
              style: bold.copyWith(color: Colors.white),
            ),
          ],
        ));
  }
}
