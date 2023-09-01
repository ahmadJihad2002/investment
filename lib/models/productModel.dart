import 'dart:io';

class ProductModel {
  // late int id;
  late double price;
  List<String> image = [];
  late String place;
  late bool isTaboo;
  late double space;
  late String classification;



  ProductModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    price = json['price'].toDouble();

    json['imagesName'].forEach((element) {
      image.add(element);
    });
    place = json['place'];
    isTaboo = json['isTaboo'];
    space = json['space'].toDouble();
    classification = json['classification'];
  }
}
