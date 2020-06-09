import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GlobalData {
  final Global global;
  final List<Country> countries;

  GlobalData({this.global, this.countries});

  factory GlobalData.fromJson(Map<String, dynamic> json) {
    var list = json['Countries'] as List;
    print(list.runtimeType);
    List<Country> listOfCountries =
        list.map((i) => Country.fromJson(i)).toList();

    return GlobalData(global: json['Global'], countries: listOfCountries);
  }
}

class Global {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeath;
  final int totalDeath;
  final int newRecovered;
  final int totalRecovered;

  Global(
      {this.newConfirmed,
      this.totalConfirmed,
      this.newDeath,
      this.totalDeath,
      this.newRecovered,
      this.totalRecovered});

  factory Global.fromJson(Map<String, dynamic> json) {
    return Global(
        newConfirmed: json['NewConfirmed'],
        totalConfirmed: json['TotalConfirmed'],
        newDeath: json['NewDeaths'],
        totalDeath: json['TotalDeaths'],
        newRecovered: json['NewRecovered'],
        totalRecovered: json['TotalRecovered']);
  }

  Future<Map<String, dynamic>> getGlobalData() async {
    Map<String, dynamic> globalData = {};
    final String url = 'https://api.covid19api.com/summary';

    try {
      var response = await http.get(url);
      var jsondata = jsonDecode(response.body);
      dynamic globalData = jsondata['Global'];

      return globalData;
    } catch (e) {
      print('An error Occued $e');
      return globalData;
    }
  }
}

class Country {
  final String country;
  final String countryCode;
  final String slug;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeath;
  final int totalDeath;
  final int newRecovered;
  final int totalRecovered;
  final String date;

  Country(
      {this.country,
      this.countryCode,
      this.slug,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeath,
      this.totalDeath,
      this.newRecovered,
      this.totalRecovered,
      this.date});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['Country'],
      countryCode: json['CountryCode'],
      slug: json['Slug'],
      newConfirmed: json['NewConfirmed'],
      totalConfirmed: json['TotalConfirmed'],
      newDeath: json['NewDeaths'],
      totalDeath: json['TotalDeaths'],
      newRecovered: json['NewRecovered'],
      totalRecovered: json['TotalRecovered'],
      date: json['Date'],
    );
  }

  static Future<Map<String, dynamic>> getCountryData(String region) async {
    Map<String, dynamic> countryData = {};

    final String url = 'https://api.covid19api.com/summary';

    try {
      var response = await http.get(url);
      var jsondata = jsonDecode(response.body);
      //var globalData = jsondata['Global'];
      var countryViseData = jsondata['Countries'];

      countryViseData.forEach((country) {
        if (region == country['Country']) {
          countryData = country;
        }
      });
      return countryData;
    } catch (e) {
      print('An error Occued $e');
      return countryData;
    }
  }
}

class LastFewDates {
  final String cases;
  final String date;

  LastFewDates({this.cases, this.date});

  factory LastFewDates.fromJson(Map<String, dynamic> json) {
    return LastFewDates(cases: json['Cases'], date: json['Date']);
  }

  Future<Map<String, dynamic>> getLAstFewDatesUpdates() async {
    Map<String, dynamic> countryData = {};
    final String url =
        'https://api.covid19api.com/total/country/south-africa/status/confirmed';

    try {
      var response = await http.get(url);
      var jsondata = jsonDecode(response.body);
      countryData = jsondata;
      return countryData;
    } catch (e) {
      print(e);
      return countryData;
    }
  }
}
