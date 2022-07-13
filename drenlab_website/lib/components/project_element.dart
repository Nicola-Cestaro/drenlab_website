import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/style.dart';

class ProjectElement extends StatelessWidget {
  const ProjectElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: min(screenSize.width * 0.88, screenSize.height / 2),
      height: screenSize.height * 0.7,
      margin: EdgeInsets.only(right: 30),
      color: backgroundColor,
    );
  }
}