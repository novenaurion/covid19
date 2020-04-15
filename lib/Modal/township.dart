class township {
  String name;
  int case_number;

  township({this.name,this.case_number});

  factory township.fromJson(Map<String, dynamic> json) {
    return township(
        name: json['name'],
        case_number: json['case'],
    );
  }

}