import 'dart:convert';

import 'package:commerce_app/constants.dart';
import 'package:commerce_app/globles.dart';
import 'package:commerce_app/product.dart';
import 'package:commerce_app/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

Future<Response> login(String username, String password) {
  const jsonEncoder = JsonEncoder();
  Map<String, String> headers = <String, String>{};
  headers[CONTENT_TYPE] = TYPE_JSON;
  headers[ACCESS_CONTROL_ALLOW_ORIGIN] = WILDCARD;
  Map<String, String> credentials = <String, String>{};
  credentials[USERNAME] = username;
  credentials[PASSWORD] = password;
  return post(Uri.parse(LOGIN_ENDPOINT),
      headers: headers, body: jsonEncoder.convert(credentials));
}

Future<Response> getProducts() {
  return get(Uri.parse(PRODUCTS_ENDPOINT));
}

Future<Response> getCategories() {
  return get(Uri.parse(CATEGORIES_ENDPOINT));
}

void getProductsAndImages(BuildContext context) {
  getProducts().then((value) {
    List<dynamic> products = jsonDecode(value.body);
    // print(products);
    for (var product in products) {
      Product productObject = Product(product);
      switch (productObject.category) {
        case ELECTRONICS_CATEGORY:
          electronicsProduct.add(productObject);
          electronicsImages.add(
            GestureDetector(
              child: Image.network(productObject.image),
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: productObject),
                  ),
                );
              },
            ),
          );
          break;
        case JEWELERY_CATEGORY:
          jeweleryProduct.add(productObject);
          jeweleryImages.add(
            GestureDetector(
              child: Image.network(productObject.image),
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: productObject),
                  ),
                );
              },
            ),
          );
          break;
        case MENS_CATEGORY:
          mensClothingProduct.add(productObject);
          mensClothingImages.add(
            GestureDetector(
              child: Image.network(productObject.image),
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: productObject),
                  ),
                );
              },
            ),
          );
          break;
        case WOMENS_CATEGORY:
          womensClothingProduct.add(productObject);
          womensClothingImages.add(
            GestureDetector(
              child: Image.network(productObject.image),
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: productObject),
                  ),
                );
              },
            ),
          );
          break;
      }
    }
  });
}

void clearLists() {
  electronicsProduct.clear();
  jeweleryProduct.clear();
  mensClothingProduct.clear();
  womensClothingProduct.clear();
  electronicsImages.clear();
  jeweleryImages.clear();
  mensClothingImages.clear();
  womensClothingImages.clear();
}
