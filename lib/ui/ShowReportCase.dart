import 'package:flutter/material.dart';

class ReportCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReportCase();
  }
}

class _ReportCase extends State<ReportCase>{
  List<String> region=["Yangon","Mandalay"];
  List<String> city=['Region '];
  String _selectedregion,_selectedCity;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
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
            Expanded(
              child: Container(
                margin:EdgeInsets.only(left:20.0),
                child: Card(
                  elevation: 5.0,
                  child: DropdownButton(
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.transparent,width: 0.0))
                      ),
                    ),
                    value:_selectedCity!=null? _selectedCity : null,
                    hint: Text('City'),
                    onChanged: (String selectedValue){
                      setState(() {
                        _selectedCity=selectedValue;
                      });
                    },
                    items: city.map((city){
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
      ],
    );
  }

//  void _showDialog() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context){
//          return AlertDialog(
//            title: Center(
//              child: Text("Report Case"),
//            ),
//            content: Form(
//              key: _formKey,
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(
//                        width:double.infinity,
//                        child: Text("Name",textAlign:TextAlign.start,)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:8.0,right:8.0),
//                    child: Container(
//                      decoration: BoxDecoration(
//                          border: Border.all(color: Colors.black)
//                      ),
//                      width: double.infinity,
//                      child: TextFormField(
//                        decoration: InputDecoration.collapsed(),
//                        style: TextStyle(
//                          fontSize: 20.0,
//                        ),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: Container(
//                          margin: EdgeInsets.only(left:15.0),
//                          child: Card(
//                            elevation: 5.0,
//                            child: DropdownButtonFormField(
////                              underline: Container(
////                                height: 1.0,
////                                decoration: const BoxDecoration(
////                                    border: Border(bottom: BorderSide(color: Colors.transparent,width: 0.0))
////                                ),
////                              ),
//                              value:_selecteddialogRegion,
//                              hint: Text(' Region'),
//                              onChanged: (String selectedValue){
//
//                                setState(() {
//                                  _selecteddialogRegion=selectedValue;
//                                  if(_selecteddialogRegion=="Yangon"){
//                                    _selecteddialogCity=null;
//                                    dialogcity.removeRange(0, city.length);
//                                    dialogcity.add("Hlaing");
//                                    dialogcity.add("TarMway");
//                                  }
//                                  else if(_selecteddialogRegion=="Mandalay"){
//                                    _selecteddialogCity=null;
//                                    dialogcity.removeRange(0, city.length);
//                                    dialogcity.add("ChanMyaTharZi");
//                                    dialogcity.add("AungMyayTharZan");
//                                  }
//                                });
//                              },
//                              items: dialogregion.map((region){
//                                return DropdownMenuItem(
//                                  child: new Text(region),
//                                  value: region,
//                                );
//                              }).toList(),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                          margin:EdgeInsets.only(left:20.0),
//                          child: Card(
//                            elevation: 5.0,
//                            child: DropdownButtonFormField(
////                              underline: Container(
////                                height: 1.0,
////                                decoration: const BoxDecoration(
////                                    border: Border(bottom: BorderSide(color: Colors.transparent,width: 0.0))
////                                ),
////                              ),
//                              value:_selecteddialogCity!=null? _selecteddialogCity : null,
//                              hint: Text('City'),
//                              onChanged: (String selectedValue){
//                                setState(() {
//                                  _selecteddialogCity=selectedValue;
//                                });
//                              },
//                              items: dialogcity.map((city){
//                                return DropdownMenuItem(
//                                  child: new Text(city),
//                                  value: city,
//                                );
//                              }).toList(),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(
//                        width:double.infinity,
//                        child: Text("Reason",textAlign:TextAlign.start,)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:8.0,right:8.0),
//                    child: Container(
//                      decoration: BoxDecoration(
//                          border: Border.all(color: Colors.black)
//                      ),
//                      width: double.infinity,
//                      child: TextFormField(
//                        decoration: InputDecoration.collapsed(),
//                        style: TextStyle(
//                          fontSize: 20.0,
//                        ),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(
//                        width:double.infinity,
//                        child: Text("Other",textAlign:TextAlign.start,)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:8.0,right:8.0),
//                    child: Container(
//                      decoration: BoxDecoration(
//                          border: Border.all(color: Colors.black)
//                      ),
//                      width: double.infinity,
//                      child: TextFormField(
//                        decoration: InputDecoration.collapsed(),
//                        style: TextStyle(
//                          fontSize: 20.0,
//                        ),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Container(
//                    width: 400,
//                    height: 100,
//                    child: InkWell(
//                      child: Card(
//                        child: Text("Report"),
//                        elevation: 5.0,
//                        color: Colors.white,
//                      ),
//                      onTap: (){},
//                    ),
//                  )
//                ],
//              ),
//            )
//          );
//        }
//    );
//  }
}