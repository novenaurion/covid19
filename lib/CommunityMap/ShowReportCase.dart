import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class ReportCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReportCase();
  }
}

class _ReportCase extends State<ReportCase> {



  final Map<String, Marker> _markers = {};
  GoogleMapController _mapController;

String yangonTotalReportCase,mandalayTotalReportCase;
final String apiYangon = "https://www.athipay.com/api/Report/SelfReports/Count/Yangon";
final String apiMandalay="https://www.athipay.com/api/Report/SelfReports/Count/Mandalay";

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height:100,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(21.9162, 95.9560),
          zoom: 5.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

Future<void> getYangonReport() async {

  var result = await http.get(apiYangon);
  setState(() {
    yangonTotalReportCase=result.body.toString();
  });
  PinInMap("Yangon",16.80528,96.15611,yangonTotalReportCase);

  print(yangonTotalReportCase);

}
Future<void> getMandalayReport() async {

  var result = await http.get(apiMandalay);
  setState(() {
    mandalayTotalReportCase=result.body.toString();
  });
  PinInMap("Mandalay",21.954510, 96.093292,mandalayTotalReportCase);


}

  @override
  void initState() {
    super.initState();
    getMandalayReport();
    getYangonReport();
  }

  void PinInMap(String name,double lat,double long,String totalcase) {
    final marker= Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: name, snippet: "Total Report Case "+totalcase),
    );
    _markers[name] =marker;
  }

}

