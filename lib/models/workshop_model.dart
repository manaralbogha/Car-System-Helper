class WorkshopModel {
  String? type;
  UserInfoModel? userInfo;
  WorkShopInfoModel? workShopInfo;
  WorkshopModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    userInfo = (json['userInfo'] != null
        ? UserInfoModel.fromJson(json['userInfo'])
        : null)!;
    workShopInfo = (json['workShopInfo'] != null
        ? WorkShopInfoModel.fromJson(json['workShopInfo'])
        : null)!;
  }
}

class UserInfoModel {
  String? fisrName;
  String? lastName;
  String? phone;
  String? email;
  UserInfoModel.fromJson(Map<String, dynamic> json) {
    fisrName = json['fisrName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
  }
}

class WorkShopInfoModel {
  String? name;
  String? address_WS;
  int? capacity;
  String? specialistID;
  List<String>? prands;
  List<String>? services;
  WorkShopInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address_WS = json['address_WS'];
    capacity = json['capacity'];
    specialistID = json['specialistID'];
    prands = json['prands'];
    services = json['services'];
  }
}
