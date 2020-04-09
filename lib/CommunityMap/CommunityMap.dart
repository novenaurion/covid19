import 'package:covid19/CommunityMap/NearbyHospital.dart';
import 'package:flutter/material.dart';

import '../CommunityMap/ShowReportCase.dart';

class CommunityMap extends StatefulWidget {

  @override
  _CommunityMapState createState() => _CommunityMapState();
}

class _CommunityMapState extends State<CommunityMap>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          labelPadding: EdgeInsets.symmetric(horizontal: 50.0),
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "Report",
            ),
            Tab(
              text: "Nearby Hospital",
            ),
          ],
        ),
        Expanded(
          child: Container(
            height: screenHeight * 0.70,
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                ReportCase(),
                NearbyHospital()
              ],
            ),
          ),
        )
      ],
    );
  }
}