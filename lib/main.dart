import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_page.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kDarkGrey,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomePage()
  ));
}

