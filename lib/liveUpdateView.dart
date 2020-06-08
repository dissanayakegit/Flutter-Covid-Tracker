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

  var updateDateTime;
  var localNewCases;
  var localTotalCases;
  var localTotalNumberOfIndividualsInHospitals;
  var localDeaths;
  var localRecovered;
  var localActiveCases;

  var globalNewCases;
  var globalTotalCases;
  var globalDeaths;
  var globalRecovered;

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
      updateDateTime = _liveData['update_date_time'];
      localNewCases = _liveData['local_new_cases'];
      localTotalCases = _liveData['local_total_cases'];
      localTotalNumberOfIndividualsInHospitals =
          _liveData['local_total_number_of_individuals_in_hospitals'];
      localDeaths = _liveData['local_deaths'];
      localRecovered = _liveData['local_recovered'];
      localActiveCases = _liveData['local_active_cases'];

      globalNewCases = _liveData['global_new_cases'];
      globalTotalCases = _liveData['global_total_cases'];
      globalDeaths = _liveData['global_deaths'];
      globalRecovered = _liveData['global_recovered'];
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
                gridItem("New Case", localNewCases, 0xFF1E88E5),
                gridItem("Total Case", localTotalCases, 0xFFE040FB),
                                gridItem("Total Recovered", localRecovered, 0xFF76FF03),

                gridItem("Total Deaths", localDeaths, 0xFFF44336),
                gridItem("Hospitalized",
                    localTotalNumberOfIndividualsInHospitals, 0xFF00E676),
                                    gridItem("Active Cases", localActiveCases, 0xFFD32F2F),

                Card(
                  color: Colors.red[700],
                  child: Center(
                      child: Text('Global',
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center)),
                ),
                gridItem("New Case", globalNewCases, 0xFF1E88E5),
                gridItem("Total Case", globalTotalCases, 0xFFE040FB),
                gridItem("Total Recoverd", globalDeaths, 0xFF76FF03),
                gridItem("Total Deaths", globalRecovered, 0xFFF44336),
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