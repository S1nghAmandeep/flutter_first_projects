import 'package:commerce_app/cart.dart';
import 'package:commerce_app/constants.dart';
import 'package:commerce_app/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.product, required this.count});

  final Product product;
  final int count;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 600,
      child: Row(
        children: [
          const Spacer(),
          Image.network(
            widget.product.image,
            width: 150,
            height: 200,
          ),
          const Spacer(),
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 12.0),
              text: TextSpan(
                style: const TextStyle(color: CupertinoColors.black),
                text: widget.product.title,
              ),
            ),
          ),
          const Spacer(),
          CupertinoButton(
            child: const Text(MINUS),
            onPressed: () {
              setState(() {
                removeProductFromCart(widget.product);
              });
            },
          ),
          Text(getCountForProduct(widget.product).toString()),
          CupertinoButton(
              child: const Text(PLUS),
              onPressed: () {
                setState(() {
                  addProductToCart(widget.product);
                });
              }),
          const Spacer(),
        ],
      ),
    );
  }
}
