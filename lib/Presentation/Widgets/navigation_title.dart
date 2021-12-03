// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:replit/Constants/colors.dart';
import 'package:replit/Constants/textStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A Widget with a clickable title, with a child view
class NavigationTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget child;
  const NavigationTitle(
      {Key? key, required this.title, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: boldTitle,
              ),
              const FaIcon(
                FontAwesomeIcons.arrowRight,
                color: lightGreen,
                size: 15,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: child,
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
