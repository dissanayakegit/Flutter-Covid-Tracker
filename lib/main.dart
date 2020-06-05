import 'package:chart_test1/homePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => HomePage(),
      },
    ));
