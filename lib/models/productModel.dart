class ProductModel {
  // late int id;
  late double price;
  List<String> image = [];
  late String place;
  late bool isTaboo;
  late double space;
  late String classification;
  late String docId;

  ProductModel.fromJson(Map<String, dynamic> json, {required String docId}) {
    // id = json['id'];
    this.docId = docId;
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
