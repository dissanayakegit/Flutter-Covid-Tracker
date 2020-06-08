import 'package:chart_test1/homePage.dart';
import 'package:chart_test1/liveUpdateView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/live',
      routes: {
        '/homepage': (context) => HomePage(),
        '/live': (context) => LiveUpdateView(),
      },
    ));
