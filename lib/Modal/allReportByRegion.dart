import 'package:covid19/Modal/township.dart';

class allReportByRegion {
  String region;
  int cases;
  List<township> townships;

  allReportByRegion({this.region,this.cases,this.townships});

  factory allReportByRegion.fromJson(Map<String, dynamic> json) {
    List<township> results = (json['townships'] as List)
        .map((Townships) => township.fromJson(Townships))
        .toList();

    return allReportByRegion(
    region: json['region'],
    cases: json['cases'],
    townships: results
    );
  }
}