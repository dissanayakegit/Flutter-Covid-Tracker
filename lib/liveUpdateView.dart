import 'package:chart_test1/services/liveData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class LiveUpdateView extends StatefulWidget {
  @override
  _LiveUpdateViewState createState() => _LiveUpdateViewState();
}

class _LiveUpdateViewState extends State<LiveUpdateView> {
  LiveUpdate liveUpdate = LiveUpdate();
  Map _liveData;

  var update_date_time;
  var local_new_cases;
  var local_total_cases;
  var local_total_number_of_individuals_in_hospitals;
  var local_deaths;
  var local_recovered;
  var local_active_cases;

  var global_new_cases;
  var global_total_cases;
  var global_deaths;
  var global_recovered;

  String updatedTime;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _liveData = await liveUpdate.getLiveData();

    updatedTime = DateFormat("yMMMMd")
        .add_jm()
        .format(DateTime.parse(_liveData['update_date_time']));

    setState(() {
      update_date_time = _liveData['update_date_time'];
      local_new_cases = _liveData['local_new_cases'];
      local_total_cases = _liveData['local_total_cases'];
      local_total_number_of_individuals_in_hospitals =
          _liveData['local_total_number_of_individuals_in_hospitals'];
      local_deaths = _liveData['local_deaths'];
      local_recovered = _liveData['local_recovered'];
      local_active_cases = _liveData['local_active_cases'];

      global_new_cases = _liveData['global_new_cases'];
      global_total_cases = _liveData['global_total_cases'];
      global_deaths = _liveData['global_deaths'];
      global_recovered = _liveData['global_recovered'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return updatedTime == null
        ? loadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('Covid19 Live Data'),
              centerTitle: true,
              backgroundColor: Colors.blue[900],
            ),
            body: StaggeredGridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              children: <Widget>[
                Card(
                  color: Colors.green[800],
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Local',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(width: 40.0),
                    Text(
                      '$updatedTime',
                      style: TextStyle(fontSize: 15.0),
                    )
                  ]),
                ),
                gridItem("New Case", local_new_cases, 0xFF1E88E5),
                gridItem("Total Case", local_total_cases, 0xFFE040FB),
                                gridItem("Total Recovered", local_recovered, 0xFF76FF03),

                gridItem("Total Deaths", local_deaths, 0xFFF44336),
                gridItem("Hospitalized",
                    local_total_number_of_individuals_in_hospitals, 0xFF00E676),
                                    gridItem("Active Cases", local_active_cases, 0xFFD32F2F),

                Card(
                  color: Colors.red[700],
                  child: Center(
                      child: Text('Global',
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center)),
                ),
                gridItem("New Case", global_new_cases, 0xFF1E88E5),
                gridItem("Total Case", global_total_cases, 0xFFE040FB),
                gridItem("Total Recoverd", global_recovered, 0xFF76FF03),
                gridItem("Total Deaths", global_deaths, 0xFFF44336),
              ],
              staggeredTiles: [
                StaggeredTile.extent(3, 70), //for title

                StaggeredTile.extent(1, 80), //new cases
                StaggeredTile.extent(2, 150), //total cases
                StaggeredTile.extent(1, 100), //total recovered
                StaggeredTile.extent(1, 130), //total deaths
                StaggeredTile.extent(1, 130), //hospitalized 
                StaggeredTile.extent(1, 95), //active cases

                StaggeredTile.extent(3, 70), //for title

                StaggeredTile.extent(1, 80), //new case
                StaggeredTile.extent(2, 150), //total case
                StaggeredTile.extent(1, 150), //total recoveres
                StaggeredTile.extent(2, 80), //total deaths
              ],
            ),
          );
  }

  Widget loadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget gridItem(String text, int amount, int color) {
    return Card(
        color: Color(color),
        elevation: 8.0,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '$amount',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
