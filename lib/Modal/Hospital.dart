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