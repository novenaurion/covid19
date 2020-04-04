import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Report extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReportState();
  }
}

class _ReportState extends State<Report> {
  Position currentPosition;
  final Map<String, Marker> _markers = {};
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Report self Quarantine"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "pinpoint your self quarantine location",
                textAlign: TextAlign.start,
              ),
              Container(
                width: double.infinity,
                height: 400,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentPosition.latitude, currentPosition.longitude),
                    zoom: 15,
                  ),
                  onTap: _handleTap,
                  markers: _markers.values.toSet(),
                ),
              ),
              SizedBox(
                height:20.0
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right:8.0),
                child: Container(
                  color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:double.infinity,
                              child: Text("Name",textAlign:TextAlign.start,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            width: double.infinity,
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(),
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width:double.infinity,
                              child: Text("Reason",textAlign:TextAlign.start,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            width: double.infinity,
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(),
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width:double.infinity,
                              child: Text("Other",textAlign:TextAlign.start,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            width: double.infinity,
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(),
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 400,
                          height: 100,
                          child: FlatButton(
                            child: Text("Report"),
                            onPressed: () {},
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getLocation() async {
    currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  _handleTap(LatLng point) {
    setState(() {
      final marker = (Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
      _markers["on tap"] = marker;
    });
  }
}
