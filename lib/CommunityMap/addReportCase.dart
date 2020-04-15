
import 'package:covid19/CommunityMap/NearbyHospital.dart';
import 'package:covid19/CommunityMap/doneReportCase.dart';
import 'package:covid19/Modal/allReportByRegion.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';

class addReportCase extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addReportCase();
  }
}

class _addReportCase extends State<addReportCase>{

  Future<allReportByRegion> reportCasefromApi;

  final _formKey = GlobalKey<FormState>();
  Random random = new Random();
  List<String> region=["ရန်ကုန်တိုင်း","မန္တလေးတိုင်း","ကချင်ပြည်နယ်","ကယားပြည်နယ်","ချင်းပြည်နယ်","တနင်္သာရီတိုင်း",
    "ပဲခူးတိုင်း","မကွေးတိုင်း","မွန်ပြည်နယ်","ရခိုင်ပြည်နယ်","ရှမ်းပြည်နယ်","ဧရာဝတီတိုင်း","နေပြည်တော်"];
  List<String> city=['Region '];
  String _selectedregion,_selectedCity;
  String startDate="Choose Date",Name;
  Map<String,dynamic> Q2;
  List<String> yangonCtiy=[
    "အင်းစိန်","မင်္ဂလာဒုံ","မှော်ဘီ","လှည်းကူး","တိုက်ကြီး","ထန်းတပင်","ရွှေပြည်သာ","လှိုင်သာယာ",
    "သင်္ဃန်းကျွန်း","ရန်ကင်း","တောင်ဥက္ကလာပ","မြောက််ဥက္ကလာပ","သာကေတ","ဒေါပုံ","တာမွေ","ပုဇွန်တောင်","ဗိုလ်တထောင်",
    "ဒဂုံမြို့သစ်(တောင်ပိုင်း)","ဒဂုံမြို့သစ်(မြောက်ပိုင်း)","ဒဂုံမြို့သစ်(အရှေ့ပိုင်း)","ဒဂုံမြို့သစ်(ဆိပ်ကမ်း)","မင်္ဂလာတောင်ညွန့်","သန်လျင်"
        "ကျောက်တန်း","သုံးခွ","ခရမ်း","တွံတေး","ကော့မှူး","ကွမ်းခြံကုန်း","ဒလ","ဆိပ်ကြီးခနောင်","ကိုကိုကျွန်း","ကျောက်တံတား","ပန်းဘဲတန်း",
    "လမ်းမတော်","လသာ","အလုံ"+"ကြည့်မြင်တိုင်","စမ်းချောင်း","လှိုင်","ကမာရွတ်","မရမ်းကုန်း","ဒဂုံ","ဗဟန်း","ဆိပ်ကမ်း"];
  List<String> mandalayCity=["အောင်မြေသာဇံ","ချမ်းမြေ့သာဇံ","မဟာအောင်မြေ","ချမ်းမြေ့သာဇီ","ပြည်ကြီးတံခွန်","အမရပူရ","ပုသိမ်ကြီး","ပြင်ဦးလွင်",
    "မတ္တရာ","စဉ့်ကူး","မိုးကုတ်","သပိတ်ကျင်း","ကျောက်ဆည်","စဉ့်ကိုင်","မြစ်သား","သပိတ်ကျင်း","တံတားဦး","မြင်းခြံ","တောင်သာ","နွားထိုးကြီး","ကျောက်ပန်းတောင်း",
    "ငါးဇွန်","ညောင်ဦး","ရမည်းသင်း","ပျော်ဘွဲ့","မိတ္ထီလာ","မလှိုင်","သာစည်","ဝမ်းတွင်း"];
  List<String> kachinRegion=["မြစ်ကြီးနား","ဝိုင်းမော်","အင်ဂျာယန်","တနိုင်း","ချီဖွေ","ဆော့လော်","မိုးညှင်း","မိုးကောင်း","ဖားကန့်","ဗန်းမော်","ရွှေကူ","မိုးမောက်","မံစီ","ပူတာအို","ဆွမ်ပရာဘွမ်","မချမ်းဆော့","ခေါင်လန်ဖူး","နောင်မွန်"];


  List<String> kayarRegion=["လွိုင်ကော်","ဒီမောဆိုး","ဖရူးဆိုး","ရှားတော","ဘောလခဲ",
    "ဖားဆောင်း","မဲဆည်"];

  List<String> kayinRegion=["ဘားအံ","လှိုင်းဘွဲ့","သံတောင်ကြီး","ဖာပွန်","မြဝတီ","ကော့ဂရိတ်","ကြားအင်းဆိပ်ကြီး"];
  List<String> chinRegion=["ဟားခါး","ထန်တလန်","ဖလမ်း","တီးတိန်","တွန်းဇံ","မတူပီ","ကန်ပက်လက်","ပလက်ဝ"];

  List<String> sagaingRegion=["စစ်ကိုင်း","မြင်းမူ","မြောင်","ရွှေဘို","ခင်ဦး","ဝက်လက်","ကန့်ဘလူ","ကျွန်းလှ",
    "ရေဦး","ဒီပဲယင်း","တန့်ဆည်"," မုံရွာ","ဘုတလင်","အရာတော်","ချောင်းဦး","ကသာ","အင်းတော်","ထီးချိုင့်","ဗန်းမောက်","ကောလင်း","ဝန်းသို","ပင်လယ်ဘူး","ကလေး","မင်းကင်း","တမူး",
    "မော်လိုက်","ဖောင်းပြင်","ခန္တီး","ဟုမ္မလင်း","လေရှီး","လဟယ်","နန်းယွန်း","ယင်းမာပင်","စလင်းကြီး","ပုလဲ","ကနီ"];

  List<String> thanintharyiRegion=["ထားဝယ်","လောင်းလုံ","သရက်ချောင်း","ရေဖြူ","မြိတ်","ကျွန်းစု","ပုလော","တနင်္သာရီ","ကော့သောင်း","ဘုတ်ပြင်း"];

  List<String> bagoRegion=["ပဲခူး","သနပ်ပင်","ကဝ","ဝေါ","ညောင်လေးပင်","ဒိုက်ဦး","ရွှေကျင်","တောင်ငူ",
    "ရေတာရှည်","ကျောက်ကြီး","ဖြူး","အုတ်တွင်း","ထန်းတပင်","ပြည်","ပေါက်ခေါင်း","ပန်းတောင်း","ပေါင်းတည်","သဲကုန်း","ရွှေတောင်",
    "သာယာဝတီ","လက်ပံလှ","မင်းလှ","အုတ်ဖို","ဇီးကုန်း","နတ်တလင်း","မြို့ရိုး","ကြို့ပင်ကောက်"];

  List<String> magwayRegion=["မကွေး","ရေနံချောင်း","ချောက်","တောင်တွင်းကြီး","မြို့သစ်","နတ်မောက်","မင်းဘူး",
    "ပွင့်ဖြူ","ငဖဲ","စလင်း","စည်တော်တစ်ရာ","သရက်","မင်းလှ","မင်းတုန်","ကံမ","အောင်လံ","ဆင်ပေါင်ဝဲ","ပခုက္ကူ",
    "ရေစကြို","မြိုင်","ပေါက်","ဆိပ်ဖြူ","ဂန့်ဂေါ","ထီးလင်း","လွှ"];

  List<String> monRegion=["မော်လမြိုင်","ကျိုက်မရော","ချောင်းဆုံ","သံဖြူဇရပ်","မုဒုံ","ရေး","သထုံ","ပေါင်","ကျိုက်ထို","ဘီလင်း"];

  List<String> rakhineRegion=["စစ်တွေ","ပုဏ္ဏားကျွန်း","ပေါက်တော","ရသေ့တောင်","မြောက်ဦး","ကျောက်တော်","မင်းပြား",
    "မောင်းတော","ဘူးသီးတောင်","ကျောက်ဖြူ","မာန်အောင်","ရမ်းဗြဲ","အမ်း","သံတွဲ","တောင်ကုန်","ဂွမြို့"];


  List<String> shanRegion=["တောင်ကြီး","ညောင်ရွေ","ဟိုပုံး","ဆီဆိုင်","ကလော","ပင်းတယ",
    "ရွာငံ","ရပ်စောက်","ပင်လောင်း","ဖယ်ခုံ","လွိုင်လင်","လဲချား","နမ့်စန်","ကွန်ဟိန်း","ကျေးသီး","မိုင်းကိုင်",
    "မိုင်းရှူး","လင်းခေး","မိုင်းလား","မောက်မယ်","လားရှိူး","သိန္နီ","မိုင်းရယ်","တန့်ယန်း","မူဆယ်","နမ့်ခမ်း","ကွတ်ခိုင်","ကျောက်မဲ","နောင်ချို","သီပေါ","နမ္မတူ",
    "နမ့်စန်","မိုးမိတ်","မဘိမ်း","မန်တုံ","ကွမ်းလုံ","လောက်ကိုင်","ကုန်ကြမ်း","ဟိုပန်","မိုင်းမော","ပန်ဝိုင်","မက်မန်း","ပန်ဆန်း","နားဖိုင်","ကျိုင်းတုံ","မိုင်းခတ်",
    "မိုင်းယန်း","မိုင်းလား","မိုင်းဆက်","မိုင်းပျဉ်း","တာချီလိတ်","မိုင်းဖြတ်","မိုင်းယောင်း"];

  List<String> ayawardyRegion=["ကန်ကြီးတောင်","ကျောင်းကုန်း","ကျုံပျော်","ငပုတော","ပုသိမ်","ရေကြည်","သာပေါင်း",
    "ကျိုက်လတ်","ဒေးဒရဲ","ဖျာပုံ","ဘိုကလေး","ညောင်တုန်း","ဓနုဖြူ","ပန်းတနော်","မအူပင်","မြောင်းမြ","ဝါးခယ်မ","အိမ်မဲ","မော်လမြိုင်ကျွန်း","လပွတ္တာ",
    "ကြံခင်း","ဇလွန်","မြန်အောင်","လေးမျက်နှာ","ဟင်္သာတ","အင်္ဂပူ"];

  List<String> naypyitawRegion=["တပ်ကုန်း","ဇေယျာသီရိ","ဥတ္တရသီရိ","ပုဗ္ဗသီရိ","ပျဥ်းမနား",
    "လယ်ဝေး","ဇမ္ဗူသီရိ","ဒက္ခိဏသီရိ"];
  String url = "https://www.athipay.com/api/Report/SelfReports";
  String checkForTravel,checkForHavingChronicDiseases,checkAge,nrcNumber;
  List<String> sympton;


  String _selectedReportRegion,_selectedReportCity,name,reason,other;
  Map<String, bool> values = {
    'Yes': false,
    'No': false,
  };


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title:Text("Add Report Case",style: TextStyle(color:Colors.black),)
      ),
      body:Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                    children: <Widget>[
                      Container(
                        padding:EdgeInsets.all(8.0),
                          child:Text("လွန်ခဲ့သော၁၄ရက်အတွင်း ခရီးသွားရာဇဝင် (သို့) ဒေသအတွင်းပျံ့နှံ့နေသည်ဟု သတင်းပို့ထားသောနေရာတွင် နေထိုင်ခြင်း ရှိခဲ့ပါသလား။ \n (သို့မဟုတ်) \n လွန်ခဲ့သော၁၄ရက်အတွင်း  Covid 19 ရှိသည် (သို့) ဖြစ်နိုင်ချေရှိသည်ဟု ယူဆထားသောသူနှင့် အနီးကပ်ထိတွေ့ဆက်ဆံမှုရှိခဲ့ပါသလား။")
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: RadioButtonGroup(
                            orientation: GroupedButtonsOrientation.HORIZONTAL,
                            margin: const EdgeInsets.only(left: 12.0),
                            labels: <String>[
                              "Yes",
                              "No"
                            ],
                            onSelected: (String selected) => setState((){
                              checkForTravel=selected;
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(

                child:Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Container(
                          padding:EdgeInsets.all(8.0),
                          child: Text("	သင့်တွင် စိုးရိမ်ဖွယ်ရှိသော အသက်ရှူလမ်းကြောင်းဆိုင်ရာ အောက်ပါရောဂါလက္ခဏာများရှိပါသလား။")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: CheckboxGroup(
                            labels: <String>[
                              "ချောင်းဆိုးခြင်း",
                              "အသက်ရှူကြပ်ခြင်း",
                              "အပူချိန် ၁၀၀ ဒီဂရီဖာရင်ဟိုက်ထက်ကျော်ခြင်း",
                              "လည်ချောင်းနာခြင်း",
                              "ဝမ်းလျှောခြင်း",
                              "ကိုယ်လက်ကိုက်ခဲခြင်း",
                              "နှာချေခြင်း",
                              "ရောဂါလက္ခဏာမပြခြင်း",
                            ],
                            onSelected: (List<String> checked) => print(checked)
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Container(
                        width: double.infinity,
                          padding:EdgeInsets.all(8.0),
                          child:Text("သင့်တွင် နာတာရှည်ရောဂါရှိပါသလား။",textAlign: TextAlign.start,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: RadioButtonGroup(
                          orientation: GroupedButtonsOrientation.HORIZONTAL,
                          margin: const EdgeInsets.only(left: 12.0),
                          labels: <String>[
                            "Yes",
                            "No"
                          ],
                          onSelected: (String selected) => setState((){
                            checkForHavingChronicDiseases=selected;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Container(
                        width: double.infinity,
                          padding:EdgeInsets.all(8.0),
                          child:Text("အသက်အရွယ်",textAlign: TextAlign.start,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: RadioButtonGroup(
                          orientation: GroupedButtonsOrientation.VERTICAL,
                          padding:EdgeInsets.all(10.0),
                          labels: <String>[
                            "၁၆နှစ်နှင့်အောက်",
                            "၁၇ နှစ် မှ ၆၄ နှစ်",
                            "၆၅ နှစ်နှင့် အထက်"
                          ],
                          onSelected: (String selected) => setState((){
                            checkAge=selected;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Text("သင်၏အမည်ကိုထည့်ပါ။",
                          textAlign: TextAlign.start,)
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,// set border color
                            width: 1.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed( ),
                        validator: (String arg) {
                          if(arg==null)
                            return 'Please fill the form';
                          else
                            return null;
                        },
                        onSaved: (input)=> Name=input,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Text("နိုင်ငံသားမှတ်ပုံတင်အမှတ် (သို့) နိုင်ငံကူးလက်မှတ်အမှတ်",
                          textAlign: TextAlign.start,)
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,// set border color
                            width: 1.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed( ),
                          validator: (String arg) {
                            if(arg==null)
                              return 'Please fill the form';
                            else
                              return null;
                          },
                        onSaved: (input)=> nrcNumber=input,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Text("ကိုယ်တိုင်စောင့်ကြည့် သည့်နေ့စွဲကိုရွေးပါ။",
                          textAlign: TextAlign.start,)
                    ),

                    Container(
                      width: double.infinity,
                      height:80.0,
                      padding: EdgeInsets.all(8.0),

                      child: InkWell(child: Card(
                        elevation: 5.0,
                        child: Center(
                          child: Text(startDate),
                        ),
                      ),
                        onTap: (){
                          showDate();
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ),

            Container(
                padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("တိုင်း/ပြည်နယ် နှင့် မြို့နယ်ကို ရွေးချယ်ပါ။",textAlign: TextAlign.start,),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(left: 15.0),
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
                                  value: _selectedregion != null
                                      ? _selectedregion
                                      : null,
                                  hint: Text('တိုင်း/ပြည်နယ်'),
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
                                  hint: Text('မြို့နယ်'),
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height:80.0,
              padding: EdgeInsets.all(8.0),

              child: InkWell(
                child: Card(
                elevation: 5.0,
                color: Colors.blueAccent,
                child: Center(
                  child: Text("ကိုယ်တိုင်သီးသန့်စောင့်ကြည့်ကာလကို တင်ပြခြင်း"),
                ),
              ),
                onTap: (){
                    checkValidation();

                },
              ),
            )
          ],
        ),
      )
    );
  }

  Future<http.Response> postToServer() async {
    Map<String, String> requestPayload ={

      "MobileUserId": "1223:123:15:122",

      "Name": Name,

      "Q1": checkForTravel,

      "Q2":"dk",

      "Q3": "မရှိ",

      "Q4": "၁၇ မှ ၆၄",

      "NRC": "၁၂/ကကက(နိုင်)၁၂၃၄၅၆",

      "Region": "ရန်ကုန်တိုင်း",

      "Township": "စမ်းချောင်းမြို့နယ်",

      "CheckinDate" : "04/04/2020"

    };
    final http.Response response = await http.post(
        'https://www.athipay.com/api/Report/SelfReports',
        body: jsonEncode(requestPayload), headers: <String, String>{
      'Content-Type': 'application/json', 'Accept': 'application/json'
    });
    print(response.statusCode.toString());
  }

  void changeCity(String selectedregion) {

    if (selectedregion == "ရန်ကုန်တိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(yangonCtiy);
    }
    else if (selectedregion =="မန္တလေးတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(mandalayCity);
    }

    else if (selectedregion =="ကချင်ပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(kachinRegion);
    }

    else if (selectedregion =="ကယားပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(kayarRegion);
    }

    else if (selectedregion =="ချင်းပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(chinRegion);
    }

    else if (selectedregion =="စစ်ကိုင်းတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(sagaingRegion);
    }

    else if (selectedregion =="တနင်္သာရီတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(thanintharyiRegion);
    }

    else if (selectedregion =="ပဲခူးတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(bagoRegion);
    }

    else if (selectedregion =="မကွေးတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(magwayRegion);
    }

    else if (selectedregion =="မွန်ပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(monRegion);
    }

    else if (selectedregion =="ရခိုင်ပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(rakhineRegion);
    }

    else if (selectedregion =="ရှမ်းပြည်နယ်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(shanRegion);
    }

    else if (selectedregion =="ဧရာဝတီတိုင်း") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(ayawardyRegion);
    }

    else if (selectedregion =="နေပြည်တော်") {
      _selectedCity = null;
      city.removeRange(0, city.length);
      city.addAll(naypyitawRegion);
    }
  }

  void showTermsandConditonDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0)),
            child: Container(
              width: 300.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                      child:Column(
                        children: <Widget>[
                          Center(
                            child: Text("Terms and Condition",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20.0),),
                          ),
                        ],
                      )
                  ),
                  Container(
                    width: double.infinity,
                    child: Text("အစတွင် ဖော်ပြထားသော Terms and Condition ကို လက်ခံနိုင်ပါသလား။"),
                  ),
                  Container(
                    child: RadioButtonGroup(
                        orientation: GroupedButtonsOrientation.HORIZONTAL,
                        margin: const EdgeInsets.only(left: 12.0),
                        labels: <String>[
                          "Yes",
                          "No"
                        ],
                        onSelected: (String selected) =>check(selected)
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  check(String selected) {
    if(selected=="Yes"){
      postToServer();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => doneReoprtCase()));
    }
  }

  void checkValidation() {
    _formKey.currentState.validate();
    _formKey.currentState.save();

    if(checkForTravel==null ||checkForHavingChronicDiseases==null ||checkAge == null|| nrcNumber ==null ||
    _selectedregion ==null || _selectedregion ==null || sympton== null || Name==null || Q2==null){
      showDialog(
          context: context,
          builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10.0)),
          child: Container(
            height: 100.0,
            width: 200.0,
            child: Card(
                color:Colors.red,
                child: Text("အထက်ပါအချက်အလက်များကို စုံလင်စွာဖြည့်စွက်ပါ။",style: TextStyle(color: Colors.white),)),
          ),
          );
     });
    }
    else{
      showTermsandConditonDialog();
    }
  }

  void showDate() {
     DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime.now(), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print(date);
          setState(() {
            startDate=formatDate(date,  [dd, '/', mm, '/', yyyy]);
          });
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

}
