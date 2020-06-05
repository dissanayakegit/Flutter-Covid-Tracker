import 'package:chart_test1/services/countryList.dart';
import 'package:chart_test1/services/covidSummery.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  var selectedCountryName;
  var countryName;
  var countrytotalConfirmed;
  var countryNewConfirmed;
  var countryNewDeaths;
  var countryTotalDeaths;
  var countryNewRecovered;
  var countryTotalRecovered;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _list = await Countries.getAllCountries();
    selectedRegion = 'Sri Lanka'; //this must be initialized here....
    setState(() {});
    _getCountryData('Sri Lanka');
  }

  _getCountryData(region) async {
    _countryData = await Country.getCountryData(region);

    setState(() {
      selectedCountryName = _countryData['Country'];
      countrytotalConfirmed = _countryData['TotalConfirmed'];
      countryNewConfirmed = _countryData['NewConfirmed'];
      countryNewDeaths = _countryData['NewDeaths'];
      countryTotalDeaths = _countryData['TotalDeaths'];
      countryNewRecovered = _countryData['NewRecovered'];
      countryTotalRecovered = _countryData['TotalRecovered'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 Summery'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: <Widget>[
          _searchableDropdown(),
          Card(
            color: Colors.green[800],
            child: Center(
                child: Text('$selectedCountryName',
                    style: TextStyle(fontSize: 25.0),
                    textAlign: TextAlign.center)),
          ),
          customeTime2("New Case", countryNewConfirmed, 0xFF1E88E5),
          customeTime2("Total Case", countrytotalConfirmed, 0xFF311B92),
          customeTime2("New Recoverd", countryNewRecovered, 0xFF00E676),
          customeTime2("Total Recoverd", countryTotalRecovered, 0xFF76FF03),
          customeTime2("Total Deaths", countryTotalDeaths, 0xFFF44336),
          customeTime2("New Deaths", countryNewDeaths, 0xFFD32F2F),
          // Card(
          //   color: Colors.red[700],
          //   child: Center(
          //       child: Text('Global',
          //           style: TextStyle(fontSize: 25.0),
          //           textAlign: TextAlign.center)),
          // ),
          // customeTime2("New Case", countryNewConfirmed, 0xFF1E88E5),
          // customeTime2("Total Case", countrytotalConfirmed, 0xFF311B92),
          // customeTime2("New Recoverd", countryNewRecovered, 0xFF00E676),
          // customeTime2("Total Recoverd", countryTotalRecovered, 0xFF76FF03),
          // customeTime2("Total Deaths", countryTotalDeaths, 0xFFF44336),
          // customeTime2("New Deaths", countryNewDeaths, 0xFFD32F2F),
        ],
        staggeredTiles: [
          //local
          StaggeredTile.extent(3, 70), //for dropbox
          StaggeredTile.extent(3, 50), //for title
          //above is title
          StaggeredTile.extent(1, 80),
          StaggeredTile.extent(2, 200),
          StaggeredTile.extent(1, 80),
          StaggeredTile.extent(1, 170),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),

          //global
          //StaggeredTile.extent(3, 50), //for title
          //above is title
          // StaggeredTile.extent(1, 80),
          // StaggeredTile.extent(2, 200),
          // StaggeredTile.extent(1, 80),
          // StaggeredTile.extent(1, 170),
          // StaggeredTile.extent(2, 130),
          // StaggeredTile.extent(2, 130),
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

  Widget customeTime2(String text, int amount, int color) {
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
