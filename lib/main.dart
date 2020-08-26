import 'package:chart_test1/homePage.dart';
import 'package:chart_test1/liveUpdateView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      // initialRoute: '/live',
      // routes: {
      //   '/homepage': (context) => HomePage(),
      //   '/live': (context) => LiveUpdateView(),
      // },

      home: DefaultTabController(
        length: 2,

        child: Scaffold(
          appBar: AppBar(
            title: Text('Covid 19 Sumary'),
            backgroundColor: Colors.green,
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text('Live Update'),
                ),
                Tab(
                  child: Text('Country wise'),
                ),
              ],
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              LiveUpdateView(),
              HomePage(),
            ],
          ),
        ),
      ),
    ));
