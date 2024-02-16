//https://youtu.be/TPd49hhnfXI?si=NW99wOVsf-0lihbz

class SqueezesDataModel {
  String? key;
  String? value;
  String? time1;
  String? time2;
  String? time3;
  String? time4;

  SqueezesDataModel({this.key, this.value, this.time1, this.time2, this.time3, this.time4});
  SqueezesDataModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    time1 = json['time1'];
    time2 = json['time2'];
    time3 = json['time3'];
    time4 = json['time4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['time1'] = this.time1;
    data['time2'] = this.time2;
    data['time3'] = this.time3;
    data['time4'] = this.time4;
    return data;
  }

  String? getTimeProperty(int index) {
    switch (index) {
      case 1:
        return time1;
      case 2:
        return time2;
      case 3:
        return time3;
      case 4:
        return time4;
      default:
        return null;
    }
  }
}
