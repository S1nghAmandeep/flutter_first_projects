import 'package:commerce_app/cart.dart';
import 'package:commerce_app/constants.dart';
import 'package:commerce_app/product.dart';
import 'package:commerce_app/top_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final formatCurrency = NumberFormat.simpleCurrency();

  late String price;

  double getWidth(String price) {
    if (price.length <= 5) {
      return 32;
    } else if (price.length == 6) {
      return 27;
    } else if (price.length == 7) {
      return 23;
    } else {
      return 21;
    }
  }

  @override
  Widget build(BuildContext context) {
    price = formatCurrency.format(widget.product.price).toString();
    return CupertinoPageScaffold(
      navigationBar: TopNav(title: widget.product.title, showBackButton: true),
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.network(
                  widget.product.image,
                  height: 300,
                  width: 300,
                ),
                Image.asset(
                  "assets/images/price_tag.png",
                  height: 100,
                  width: 100,
                ),
                Wrap(
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15, color: CupertinoColors.white),
                    ),
                    SizedBox(
                      height: 60,
                      width: getWidth(price),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 700,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 250,
              height: 50,
              child: CupertinoButton.filled(
                child: const Text(
                  ADD_TO_CART,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    addProductToCart(widget.product);
                  });
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text(ADDED_TO_CART),
                          content:
                              Text("${widget.product.title} was added to cart"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(OK),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
