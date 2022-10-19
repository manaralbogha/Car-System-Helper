class LoginModel {
  late bool status;
  late UserData data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['state'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  late String message;
  late String? token;
  late String? type;

  UserData({
    required this.message,
    required this.token,
    required this.type,
  });
  UserData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    type = json['type'];
  }
}
