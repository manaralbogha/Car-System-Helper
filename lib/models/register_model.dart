class RegisterModel {
  late bool status;
  late UserData data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['state'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  String? message;
  String? type;

  UserData({this.message, this.type});
  UserData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
  }
}
