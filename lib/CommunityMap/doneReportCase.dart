import 'package:covid19/ui/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class doneReoprtCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _doneReoprtCaseState();
  }
}

class _doneReoprtCaseState extends State<doneReoprtCase>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Report Case"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.red[800],
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("သင်၏ ကိုယ်တိုင် စောင့်ကြည့်မှူ တင်သွင်းခြင်း အောင်မြင်ပါသည်",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white,),textAlign: TextAlign.center,),
                  )
                ),
              ),
              Container(
                child:Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("COVID-19 ရောဂါ ပျံ့နှံ့ခြင်းမှ ရှောင်ရှားရန် : \n\n "
                        "⦁	မိမိအိမ်တွင်ပါ လူမှုအကွာအဝေးကို လေ့ကျင့်ပါ။ သက်ကြီးရွယ်အိုများနှင့် မကျန်းမားသောသူများထံမှ ဝေးဝေးနေခြင်း ကိုပြုလုပ်ပါ။ \n"
                    "⦁	လက်များကို ဆပ်ပြာနှင့်ရေဖြင့် မကြာခဏဆေးကြောပါ။ အိမ်တွင် အသုံးအဆောင် ပစ္စည်းများ မျှဝေသုံးဆွဲခြင်းကို ရှောင်ပါ။\n"
                    "⦁	ရေများများသောက်ပြီး ကျန်းမာသောအစားအစာကိုစားပါ။\n"
                    "⦁	လုံလောက်သောအိပ်စက်အနားယူခြင်းကို ပြုလုပ်ပါ။ ဆေးလိပ်နှင့် အရက်သောက်ခြင်းကို ရှောင်ပါ။\n"
                    "⦁	ရောဂါလက္ခဏာအသစ်များပေါ်ပေါက်လာပါက သို့မဟုတ် သင်၏လက်ရှိလက္ခဏာများ ပိုမိုဆိုးရွားလာပါက ဤစစ်ဆေးခြင်းလုပ်ဆောင်ချက်တွင် ထပ်မံအသစ်ဖြည့်ပါ။ \n"
                        "⦁	ဆရာဝန် ပြောင်းလဲကုသခြင်းကို ရှောင်ပါ။ သင်၏အခြေအနေပြောင်းလဲသွားပါက သူ သို့မဟုတ် သူမသည် သင့်အားပိုမိုကောင်းမွန်စွာ စောင့်ကြည့်ပြီး သင့်အတွက်အကောင်းဆုံးစောင့်ရှောက်မှုကို ပေးနိုင်ပါသည်။"),

                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                height: 80.0,
                child: InkWell(
                  child: Card(
                    color: Colors.blueAccent,
                    child: Center(child: Text("OK",style: TextStyle(fontSize: 20.0),)),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MainPage()));
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}