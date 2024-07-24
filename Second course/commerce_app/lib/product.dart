import 'package:commerce_app/constants.dart';

class Product {
  Product(var json) {
    id = json[ID];
    title = json[TITLE];
    price = double.parse(json[PRICE].toString());
    category = json[CATEGORY];
    description = json[DESCRIPTION];
    image = json[IMAGE];
  }

  late int id;
  late String title;
  late double price;
  late String category;
  late String description;
  late String image;

}