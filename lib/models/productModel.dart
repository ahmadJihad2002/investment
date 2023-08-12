import 'dart:ffi';

class ProductModel {
  late int id;
  late double price;
  late String image;
  late String place;
  late bool isTaboo;
  late Double space;
  late Double classification;

// dynamic? oldPrice;
// dynamic? discount;
// String? image;
// String? name;
// bool? inCart;

  ProductModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    place = json['place'];
    isTaboo = json['isTaboo'];
    space = json['space'];
    classification = json['classification'];
  }
}
