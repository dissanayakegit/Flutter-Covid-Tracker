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
  final String update_date_time;
  final String local_new_cases;
  final String local_total_cases;
  final String local_total_number_of_individuals_in_hospitals;
  final String local_deaths;
  final String local_recovered;
  final String local_active_cases;

  final String global_new_cases;
  final String global_total_cases;
  final String global_deaths;
  final String global_recovered;

  LiveUpdate(
      {this.update_date_time,
      this.local_new_cases,
      this.local_total_cases,
      this.local_total_number_of_individuals_in_hospitals,
      this.local_deaths,
      this.local_recovered,
      this.local_active_cases,
      this.global_new_cases,
      this.global_total_cases,
      this.global_deaths,
      this.global_recovered});

  factory LiveUpdate.fromJson(Map<String, dynamic> json) {
    return LiveUpdate(
        update_date_time: json['update_date_time'],
        local_new_cases: json['local_new_cases'],
        local_total_cases: json['local_total_cases'],
        local_total_number_of_individuals_in_hospitals:
            json['local_total_number_of_individuals_in_hospitals'],
        local_deaths: json['local_deaths'],
        local_recovered: json['local_recovered'],
        local_active_cases: json['local_active_cases'],
        global_new_cases: json['global_new_cases'],
        global_total_cases: json['global_total_cases'],
        global_deaths: json['global_deaths'],
        global_recovered: json['global_recovered']);
  }

  Future<Map<String, dynamic>> getLiveData() async {
    Map<String, dynamic> countryData = {};

    final String url =
        'https://www.hpb.health.gov.lk/api/get-current-statistical';

    try {
      var response = await http.get(url);
      var jsondata = jsonDecode(response.body);
      print(jsondata['data']);
      countryData = jsondata['data'];
      return countryData;
    } catch (e) {
      print(e);
      return countryData;
    }
  }
}
