import 'dart:convert';
import 'dart:ui';
import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NearbyHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NearByHospitalState();
  }
}

class _NearByHospitalState extends State<NearbyHospital>{
  List<String> region=["ရန်ကုန်","မန္တလေး"];
  List<String> city=['Region '];
  String _selectedregion,_selectedCity;
  List<String> yangonCtiy=[
    "အင်းစိန်","မင်္ဂလာဒုံ","မှော်ဘီ","လှည်းကူး","တိုက်ကြီး","ထန်းတပင်","ရွှေပြည်သာ","လှိုင်သာယာ",
    "သင်္ဃန်းကျွန်း","ရန်ကင်း","တောင်ဥက္ကလာပ","မြောက််ဥက္ကလာပ","သာကေတ","ဒေါပုံ","တာမွေ","ပုဇွန်တောင်","ဗိုလ်တထောင်",
    "ဒဂုံမြို့သစ်(တောင်ပိုင်း)","ဒဂုံမြို့သစ်(မြောက်ပိုင်း)","ဒဂုံမြို့သစ်(အရှေ့ပိုင်း)","ဒဂုံမြို့သစ်(ဆိပ်ကမ်း)","မင်္ဂလာတောင်ညွန့်","သန်လျင်"
        "ကျောက်တန်း","သုံးခွ","ခရမ်း","တွံတေး","ကော့မှူး","ကွမ်းခြံကုန်း","ဒလ","ဆိပ်ကြီးခနောင်","ကိုကိုကျွန်း","ကျောက်တံတား","ပန်းဘဲတန်း",
    "လမ်းမတော်","လသာ","အလုံ"+"ကြည့်မြင်တိုင်","စမ်းချောင်း","လှိုင်","ကမာရွတ်","မရမ်းကုန်း","ဒဂုံ","ဗဟန်း","ဆိပ်ကမ်း"];
  List<String> mandalayCity=["အောင်မြေသာဇံ","ချမ်းမြေ့သာဇံ","မဟာအောင်မြေ","ချမ်းမြေ့သာဇီ","ပြည်ကြီးတံခွန်","အမရပူရ","ပုသိမ်ကြီး","ပြင်ဦးလွင်",
    "မတ္တရာ","စဉ့်ကူး","မိုးကုတ်","သပိတ်ကျင်း","ကျောက်ဆည်","စဉ့်ကိုင်","မြစ်သား","သပိတ်ကျင်း","တံတားဦး","မြင်းခြံ","တောင်သာ","နွားထိုးကြီး","ကျောက်ပန်းတောင်း",
    "ငါးဇွန်","ညောင်ဦး","ရမည်းသင်း","ပျော်ဘွဲ့","မိတ္ထီလာ","မလှိုင်","သာစည်","ဝမ်းတွင်း"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: Card(
                        elevation: 5.0,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(
                            height: 1.0,
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))
                            ),
                          ),
                          value: _selectedregion != null
                              ? _selectedregion
                              : null,
                          hint: Text('Region'),
                          onChanged: (String selectedValue) {
                            setState(() {
                              _selectedregion = selectedValue;
                              changeCity(selectedValue);
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
                  ),
                  Flexible(
                    child: Container(
                      child: Card(
                        elevation: 5.0,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(
                            height: 1.0,
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))
                            ),
                          ),
                          value: _selectedCity != null
                              ? _selectedCity
                              : null,
                          hint: Text('City'),
                          onChanged: (String selectedValue) {
                            setState(() {
                              _selectedCity = selectedValue;
                            });
                          },
                          items: city.map((city) {
                            return DropdownMenuItem(
                              child: new Text(city),
                              value: city,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Container(
                height:1000.00,
                child: FutureBuilder<List<Hospital>>(
                  future: _fetchHospitals(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Hospital> data = snapshot.data;

                      return _HospitalListView(data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: Container(
                          height:50.0,
                          child: CircularProgressIndicator()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<List<Hospital>> _fetchHospitals() async {
    if(_selectedCity==null){
      final url = 'https://www.athipay.com/api/Locations/Hospitals';
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((hospital) => new Hospital.fromJson(hospital))
            .toList();
      } else {
        throw Exception('Failed to load jobs from API');
      }
    }
    else{
      final url = 'https://www.athipay.com/api/Locations/Hospitals/'+_selectedCity;
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((hospital) => new Hospital.fromJson(hospital))
            .toList();
      } else {
        throw Exception('Failed to load jobs from API');
      }
    }

  }

  Widget _HospitalListView(List<Hospital> data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _view(
              data[index].fullName, data[index].address, data[index].phones);
        });
  }

  Widget _view(String fullName, String address, List<dynamic> phones) {
    if (phones.length == 1) {
      return Container(

        child: Card(

            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(fullName, style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.start,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(address, textAlign: TextAlign.start)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: double.infinity,
                      child: Text(phones[0], textAlign: TextAlign.start),
                    ),
                    onTap: (){
                      callNumber(phones[0]);
                    },
                  ),
                ),
              ],
            )
        ),
      );
    }
    else if (phones.length == 2) {
      return Container(

        child: Card(

            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(fullName, style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.start,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(address, textAlign: TextAlign.start)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Container(
                          width: double.infinity,
                          child: Text(phones[0], textAlign: TextAlign.start)),
                      onTap:(){
                        callNumber(phones[0]);
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Container(
                          width: double.infinity,
                          child: Text(phones[1], textAlign: TextAlign.start)),
                      onTap:(){
                        callNumber(phones[1]);
                      }
                  ),
                ),
              ],
            )
        ),
      );
    }
    else if (phones.length > 2) {
      return Container(

        child: Card(

            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(fullName, style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.start,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      child: Text(address, textAlign: TextAlign.start)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Container(
                          width: double.infinity,
                          child: Text(phones[0], textAlign: TextAlign.start)),
                      onTap:(){
                        callNumber(phones[0]);
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Container(
                          width: double.infinity,
                          child: Text(phones[1], textAlign: TextAlign.start)),
                      onTap:(){
                        callNumber(phones[1]);
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Container(
                          width: double.infinity,
                          child: Text(phones[2], textAlign: TextAlign.start)),
                      onTap:(){
                        callNumber(phones[2]);
                      }
                  ),
                ),
              ],
            )
        ),
      );
    }
  }

  void callNumber(String phno) async{
    await new CallNumber().callNumber('+95' +phno);
  }

  void changeCity(String selectedregion) {

    if (selectedregion == "ရန်ကုန်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(yangonCtiy);
          }
    else if (selectedregion =="မန္တလေး") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(mandalayCity);
    }
  }

}
class Hospital {
  String fullName;
  String address;
  String region;
  String township;
  List<dynamic> phones;

  Hospital({this.fullName,this.address,this.region,this.township,this.phones});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        fullName: json['fullName'],
        address: json['address'],
        region: json['region'],
        township: json['township'],
        phones:json['phones']
    );
  }

}
