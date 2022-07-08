import 'package:drenlab_website/theme/style.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drenlab',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LandingPage(),
    );
  }
}
