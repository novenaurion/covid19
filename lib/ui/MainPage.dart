import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:covid19/CommunityMap/CommunityMap.dart';
import 'package:covid19/ui/Report.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }

}

class _MainPageState extends State<MainPage> {

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
      appBar: AppBar(
          title: Text("Covid")
      ),
      body: CommunityMap()
    );
  }

  void _getLocation() async {
    currentPosition = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(()  {

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