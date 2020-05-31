import 'package:chart_test1/homePage.dart';
import 'package:chart_test1/pieChart.dart';
import 'package:chart_test1/summeryChart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/homepage',

  routes: {
    '/homepage' : (context) => HomePage(),
    '/chart' : (context) => SummeryChart(),
  },
));



