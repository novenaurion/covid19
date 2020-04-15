class  Question2{
  String answer;
  Question2({this.answer});

  Map<String, dynamic> toJson() =>  {
   'answer':answer
  };
}