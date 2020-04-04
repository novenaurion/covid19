import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class addReportCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addReportCase();
  }
}

class _addReportCase extends State<addReportCase>{
  final _formKey = GlobalKey<FormState>();
  List<String> addReportRegion=["Yangon","Mandalay"];
  List<String> addReportCity=['Region '];

  String _selectedReportRegion,_selectedReportCity,name,reason,other;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text("Add Report Case",style: TextStyle(color:Colors.black),)
      ),
      body:Form(
        key: _formKey,
        child: Container(
          padding:EdgeInsets.all(8.0),
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
              SizedBox(
                height: 20.0,
              ),
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
                          value:_selectedReportRegion,
                          hint: Text(' Region'),
                          onChanged: (String selectedValue){

                            setState(() {
                              _selectedReportRegion=selectedValue;
                              if(_selectedReportRegion=="Yangon"){
                                _selectedReportCity=null;
                                addReportCity.removeRange(0, addReportCity.length);
                                addReportCity.add("Hlaing");
                                addReportCity.add("TarMway");
                              }
                              else if(_selectedReportRegion=="Mandalay"){
                                _selectedReportRegion=null;
                                addReportCity.removeRange(0, addReportCity.length);
                                addReportCity.add("ChanMyaTharZi");
                                addReportCity.add("AungMyayTharZan");
                              }
                            });
                          },
                          items: addReportRegion.map((region){
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
                          value:_selectedReportCity!=null? _selectedReportCity : null,
                          hint: Text('City'),
                          onChanged: (String selectedValue){
                            setState(() {
                              _selectedReportCity=selectedValue;
                            });
                          },
                          items: addReportCity.map((city){
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
                    onSaved:(value){
                      name=value;
                    },
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
                    onSaved:(value){
                      reason=value;
                    },
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
                    onSaved:(value){
                      other=value;
                    },
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
              Card(
                elevation: 5.0,
                child: Container(
                  width: 250,
                  height: 50,
                  child: FlatButton(
                    onPressed:(){
                      _formKey.currentState.save();
                    },
                    child: Text("Report"),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}