import 'package:chart_test1/services/countryList.dart';
import 'package:chart_test1/services/covidSummery.dart';
import 'package:chart_test1/summeryChart.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _searchableDropdown(),
              Card(
                child: ListTile(
                  title: Text('Country : $selectedCountryName'),
                  // onTap: Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SummeryChart())),
                ),
                color: Colors.pink[200],
              ),
              Card(
                child: ListTile(
                  title: Text('Total Confirmed : $countrytotalConfirmed'),
                ),
                color: Colors.amber[900],
              ),
              Card(
                child: ListTile(
                  title: Text('New Confirmed : $countryNewConfirmed'),
                ),
                color: Colors.amber[500],
              ),
              Card(
                child: ListTile(
                  title: Text('New Deaths : $countryNewDeaths'),
                ),
                color: Colors.red[500],
              ),
              Card(
                child: ListTile(
                  title: Text('Total Deaths : $countryTotalDeaths'),
                ),
                color: Colors.red[700],
              ),
              Card(
                child: ListTile(
                  title: Text('New Recovered : $countryNewRecovered'),
                ),
                color: Colors.blue[400],
              ),
              Card(
                child: ListTile(
                  title: Text('Total Recovered : $countryTotalRecovered'),
                ),
                color: Colors.lightGreenAccent[400],
              ),
            ],
          ),
        ),
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
}
