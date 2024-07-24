import 'package:commerce_app/cart_item.dart';
import 'package:commerce_app/constants.dart';
import 'package:commerce_app/events.dart';
import 'package:commerce_app/globles.dart';
import 'package:commerce_app/top_nav.dart';
import 'package:flutter/cupertino.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    refreshCart();
    eventBus.on<RefreshCartEvent>().listen((event) {
      if (mounted) {
        refreshCart();
      }
    });
  }

  void refreshCart() {
    setState(() {
      cartItems.clear();
      productsInCart.forEach((key, value) {
        CartItem cartItem = CartItem(product: key, count: value);
        cartItems.add(cartItem);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const TopNav(title: CART, showBackButton: true),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Column(
                children: cartItems,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
