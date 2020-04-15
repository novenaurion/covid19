import 'dart:async';
import 'package:covid19/CommunityMap/NearbyHospital.dart';
import 'package:covid19/CommunityMap/addReportCase.dart';
import 'package:covid19/Modal/allReportByRegion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }

}

class _MainPageState extends State<MainPage> {


  List<String> region=["ရန်ကုန်တိုင်း","Mandalay"];
  String _selectedregion="ရန်ကုန်တိုင်း";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("Covid")
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: DropdownButton(
                isExpanded: true,
                underline: Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(
                          color: Colors.transparent, width: 0.0))
                  ),
                ),
                value: _selectedregion,
                hint: Text('Region'),
                onChanged: (String selectedValue) {
                  setState(() {
                    _selectedregion = selectedValue;
                  });
                },
                items: region.map((region) {
                  return DropdownMenuItem(
                    child: new Text(region),
                    value: region,
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height:500.00,
            child: FutureBuilder<List<allReportByRegion>>(
              future: fetchCase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<allReportByRegion> data = snapshot.data;

                  return showTable(data);

                } else if (snapshot.hasError) {
                  return    Container(
                    padding: EdgeInsets.all(12.0),
                    height: 100.0,
                    child: Card(
                      child: Center(
                        child: Text(
                          _selectedregion + " တွင် မိမိကိုယ်ကိုစောင့်ကြည့်နေသူ မရှိပါ",textAlign: TextAlign.center,),
                      ),
                    ),
                  );
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
          Container(
            height:80.0,
            padding:EdgeInsets.all (10.0),
            child:InkWell(
              child: Card(
                elevation: 5.0,
                child: Center(child: Text("ကိုယ်တိုင်သီးသန့်စောင့်ကြည့်ကာလကို တင်ပြခြင်း")),
              ),
              onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> addReportCase()));
              },
            )
          ),

          Container(
            height: 80.0,
            padding: EdgeInsets.all(10.0),
              child:InkWell(
                child: Card(
                  elevation: 5.0,
                  child: Center(child: Text("အနီးနားရှိ ဆေးရုံများ")),
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> NearbyHospital()));
                },
              )
          )

        ],
      )
    );
  }

  Future<List<allReportByRegion>> fetchCase() async {

      final url = 'https://www.athipay.com/api/Report/Regionals/'+_selectedregion;
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((result) => new allReportByRegion.fromJson(result))
            .toList();
      } else {
        throw Exception('Failed to load jobs from API');
      }

  }

  Widget showTable(List<allReportByRegion> data) {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(data[index].townships);

          List<DataRow> rows = [];

          data[index].townships.forEach((row){
              rows.add(
                  DataRow(
                      cells: [
                        DataCell(
                          Text(row.name),
                        ),
                        DataCell(
                          Text(row.case_number.toString()),
                        ),
                      ]
                  )
              );
          });

          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12.0),
                  height: 100.0,
                  child: Card(
                    child: Center(
                      child: Text(
                          data[index].region + " တွင် မိမိကိုယ်ကိုစောင့်ကြည့်နေသူ စုစုပေါင်း" +
                              data[index].cases.toString()+ " ယောက်ရှိပါသည်",textAlign: TextAlign.center,),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  
                  child: Card(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('မြို့နယ်')),
                        DataColumn(label: Text('အရေအတွက်')),
                      ],
                      rows:rows,
                      ),
                  ),
                  ),
              ],
            ),
          );
        });
  }
}