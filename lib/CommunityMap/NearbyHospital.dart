import 'package:flutter/material.dart';

class NearbyHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NearByHospitalState();
  }
}

class _NearByHospitalState extends State<NearbyHospital>{
  List<String> region=["Yangon","Mandalay"];
  List<String> city=['Region '];
  String _selectedregion,_selectedCity;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Near By Hospital"),
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left:15.0),
                  child: Card(
                    elevation: 5.0,
                    child: DropdownButton(
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.transparent,width: 0.0))
                        ),
                      ),
                      value:_selectedregion!=null? _selectedregion : null,
                      hint: Text(' Region'),
                      onChanged: (String selectedValue){
                        setState(() {
                          _selectedregion=selectedValue;
                          if(_selectedregion=="Yangon"){
                            _selectedCity=null;
                            city.removeRange(0, city.length);
                            city.add("Hlaing");
                            city.add("TarMway");
                          }
                          else if(_selectedregion=="Mandalay"){
                            _selectedCity=null;
                            city.removeRange(0, city.length);
                            city.add("ChanMyaTharZi");
                            city.add("AungMyayTharZan");
                          }
                        });
                      },
                      items: region.map((region){
                        return DropdownMenuItem(
                          child: new Text(region),
                          value: region,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}