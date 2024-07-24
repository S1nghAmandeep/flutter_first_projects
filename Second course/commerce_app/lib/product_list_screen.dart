import 'dart:async';

import 'package:commerce_app/constants.dart';
import 'package:commerce_app/globles.dart';
import 'package:commerce_app/top_nav.dart';
import 'package:flutter/cupertino.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum Category { electronics, jewelery, mens, womens }

class _ProductListScreenState extends State<ProductListScreen> {
  Category currentCategory = Category.electronics;
  List<GestureDetector> currentProductCategoryList = [];
  late final Timer timer;
  int index = 0;
  List<Image> previewImages = [];

  @override
  void initState() {
    super.initState();
    updateProductsDisplay(Category.electronics);
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        index++;
      });
    });
    // mensClothingProduct.forEach((element) {
    //   previewImages.add(Image.network(element.image));
    // });
    for (var element in mensClothingProduct) {
      previewImages.add(Image.network(element.image));
    }
  }

  void updateProductsDisplay(Category category) {
    currentCategory = category;
    setState(() {
      switch (currentCategory) {
        case Category.electronics:
          currentProductCategoryList = electronicsImages;
          break;
        case Category.jewelery:
          currentProductCategoryList = jeweleryImages;
          break;
        case Category.mens:
          currentProductCategoryList = mensClothingImages;
          break;
        case Category.womens:
          currentProductCategoryList = womensClothingImages;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const TopNav(title: SHOP, showBackButton: false),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: previewImages[index % previewImages.length],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            CupertinoSlidingSegmentedControl(
              groupValue: currentCategory,
              onValueChanged: (value) {
                updateProductsDisplay(value!);
              },
              children: const <Category, Widget>{
                Category.electronics: Text(ELECTRONICS),
                Category.jewelery: Text(JEWELERY),
                Category.mens: Text(MENS),
                Category.womens: Text(WOMENS),
              },
            ),
            SizedBox(
              height: 450,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: const EdgeInsets.all(80),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: currentProductCategoryList,
              ),
            )
          ],
        ),
      ),
    );
  }
}
