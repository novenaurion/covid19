import 'package:covid19/ui/NestedTabBarView..dart';
import 'package:covid19/ui/ShowReportCase.dart';
import 'package:covid19/ui/addReportCase.dart';
import 'package:flutter/material.dart';


class CommunityMap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommunityMap();
  }
}

  class _CommunityMap extends State<CommunityMap> with SingleTickerProviderStateMixin{



  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Community Map",style: TextStyle(color: Colors.black),),
        bottom: TabBar(
          controller: _tabController,
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
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ReportCase(),
          NearbyHospital(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => addReportCase()));
        },
      ) :null
    );
  }
  }