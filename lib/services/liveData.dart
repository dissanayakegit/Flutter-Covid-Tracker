import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Wholedata {
  LiveUpdate liveUpdate;

  Wholedata({this.liveUpdate});

  factory Wholedata.fromJson(Map<String, dynamic> parsedJson) {
    return Wholedata(liveUpdate: LiveUpdate.fromJson(parsedJson['liveUpdate']));
  }
}

class LiveUpdate {
  final String updateDateTime;
  final String localNewCases;
  final String localTotalCases;
  final String localTotalNumberOfIndividualsInHospitals;
  final String localDeaths;
  final String localRecovered;
  final String localActiveCases;

  final String globalNewCases;
  final String globalTotalCases;
  final String globalDeaths;
  final String globalRecovered;

  LiveUpdate(
      {this.updateDateTime,
      this.localNewCases,
      this.localTotalCases,
      this.localTotalNumberOfIndividualsInHospitals,
      this.localDeaths,
      this.localRecovered,
      this.localActiveCases,
      this.globalNewCases,
      this.globalTotalCases,
      this.globalDeaths,
      this.globalRecovered});

  factory LiveUpdate.fromJson(Map<String, dynamic> json) {
    return LiveUpdate(
        updateDateTime: json['update_date_time'],
        localNewCases: json['local_new_cases'],
        localTotalCases: json['local_total_cases'],
        localTotalNumberOfIndividualsInHospitals:
            json['local_total_number_of_individuals_in_hospitals'],
        localDeaths: json['local_deaths'],
        localRecovered: json['local_recovered'],
        localActiveCases: json['local_active_cases'],
        globalNewCases: json['global_new_cases'],
        globalTotalCases: json['global_total_cases'],
        globalDeaths: json['global_deaths'],
        globalRecovered: json['global_recovered']);
  }

  Future<Map<String, dynamic>> getLiveData() async {
    Map<String, dynamic> countryData = {};

    final String url =
        'https://www.hpb.health.gov.lk/api/get-current-statistical';

    try {
      var response = await http.get(url);
      var jsondata = jsonDecode(response.body);
      countryData = jsondata['data'];
      return countryData;
    } catch (e) {
      print(e);
      return countryData;
    }
  }
}
