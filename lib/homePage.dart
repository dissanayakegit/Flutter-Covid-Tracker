import 'package:chart_test1/services/countryList.dart';
import 'package:chart_test1/services/covidSummery.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Countries countries = Countries(); //Create Countries model object
  List<Countries> _list = []; //Create list to store list of countries

  Country country = Country(); //Create Country model object
  Map<dynamic, dynamic> countrydata = {}; //Create Map to store country data
  String selectedRegion;
  Map _countryData;

  Global global = Global();
  Map _globalData;

  String updatedTime;

  var selectedCountryName;
  var countryName;
  var countrytotalConfirmed;
  var countryNewConfirmed;
  var countryNewDeaths;
  var countryTotalDeaths;
  var countryNewRecovered;
  var countryTotalRecovered;
  var dateOfStatus;
  var activeCases;

  var globalName;
  var globaltotalConfirmed;
  var globalNewConfirmed;
  var globalNewDeaths;
  var globalTotalDeaths;
  var globalNewRecovered;
  var globalTotalRecovered;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _globalData = await global.getGlobalData();
    _list = await Countries.getAllCountries();
    selectedRegion = 'Sri Lanka'; //this must be initialized here....
    setState(() {});
    _getCountryData('Sri Lanka');
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _getCountryData(region) async {
    _countryData = await Country.getCountryData(region);

    if (_countryData['Date'] != null) {
      updatedTime = DateFormat("yMMMMd")
          .add_jm()
          .format(DateTime.parse(_countryData['Date']));
    }

    setState(() {
      selectedCountryName = _countryData['Country'];
      countrytotalConfirmed = _countryData['TotalConfirmed'];
      countryNewConfirmed = _countryData['NewConfirmed'];
      countryNewDeaths = _countryData['NewDeaths'];
      countryTotalDeaths = _countryData['TotalDeaths'];
      countryNewRecovered = _countryData['NewRecovered'];
      countryTotalRecovered = _countryData['TotalRecovered'];
      dateOfStatus = _countryData['Date'];
      activeCases = countrytotalConfirmed - (countryTotalRecovered + countryTotalDeaths);

      globaltotalConfirmed = _globalData['TotalConfirmed'];
      globalNewConfirmed = _globalData['NewConfirmed'];
      globalNewDeaths = _globalData['NewDeaths'];
      globalTotalDeaths = _globalData['TotalDeaths'];
      globalNewRecovered = _globalData['NewRecovered'];
      globalTotalRecovered = _globalData['TotalRecovered'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Covid19 Summery'),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue[900],
      // ),
      body: updatedTime == null
          ? loadingScreen()
          : StaggeredGridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              children: <Widget>[
                _searchableDropdown(),
                Card(
                  color: Colors.green[800],
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$selectedCountryName',
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
                gridItem("New Cases", countryNewConfirmed, 0xFF1E88E5),
                gridItem("Total Cases", countrytotalConfirmed, 0xFFE040FB),
                gridItem("New Recoverd", countryNewRecovered, 0xFF00E676),
                gridItem("Active Cases", activeCases, 0xFF90A4AE),
                gridItem("Total Recoverd", countryTotalRecovered, 0xFF76FF03),
                gridItem("Total Deaths", countryTotalDeaths, 0xFFF44336),
                gridItem("New Deaths", countryNewDeaths, 0xFFD32F2F),
                Card(
                  color: Colors.red[700],
                  child: Center(
                      child: Text('Global',
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center)),
                ),
                gridItem("New Cases", globalNewConfirmed, 0xFF1E88E5),
                gridItem("Total Recoverd", globalTotalRecovered, 0xFF76FF03),
                gridItem("New Recoverd", globalNewRecovered, 0xFF00E676),
                gridItem("New Deaths", globalNewDeaths, 0xFFD32F2F),
                gridItem("Total Deaths", globalTotalDeaths, 0xFFF44336),
                gridItem("Total Cases", globaltotalConfirmed, 0xFFE040FB),
              ],
              staggeredTiles: [
                //local
                StaggeredTile.extent(3, 70), //for dropbox
                StaggeredTile.extent(3, 70), //for title
                //above is title
                StaggeredTile.extent(1, 80), //new cases
                StaggeredTile.extent(2, 120), //total case
                StaggeredTile.extent(1, 80), //new recovered
                StaggeredTile.extent(2, 80), //active cases
                StaggeredTile.extent(1, 170), //total revcovered
                StaggeredTile.extent(1, 135), //total deaths
                StaggeredTile.extent(1, 135),//new deaths

                //global
                StaggeredTile.extent(3, 50), //for title
                //above is title
                StaggeredTile.extent(1, 80),
                StaggeredTile.extent(2, 200),
                StaggeredTile.extent(1, 80),
                StaggeredTile.extent(1, 170),
                StaggeredTile.extent(2, 135),
                StaggeredTile.extent(3, 130),
              ],
            ),
    );
  }

  Widget _searchableDropdown() {
    return SearchableDropdown.single(
      items: _list.map((Countries map) {
        return DropdownMenuItem<String>(
          value: map.country,
          child: Text('${map.country}', style: TextStyle(color: Colors.black)),
        );
      }).toList(),
      value: selectedRegion,
      hint: "Select Country",
      searchHint: "Select Country",
      onChanged: (String value) {
        setState(() {
          selectedRegion = value;
        });
        _getCountryData(selectedRegion);
        //print(selectedRegion);
      },
      isExpanded: true,
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
