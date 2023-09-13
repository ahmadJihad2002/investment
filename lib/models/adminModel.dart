class AdminModel {
  late String? name;
  late String? uId;
  late String? phoneNumber;

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    uId = json['uId'];
  }
}
