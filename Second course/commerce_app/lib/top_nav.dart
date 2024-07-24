import 'package:badges/badges.dart';
import 'package:commerce_app/cart.dart';
import 'package:commerce_app/cart_screen.dart';
import 'package:commerce_app/constants.dart';
import 'package:commerce_app/events.dart';
import 'package:commerce_app/globles.dart';
import 'package:commerce_app/main.dart';
import 'package:flutter/cupertino.dart';

class TopNav extends StatefulWidget implements ObstructingPreferredSizeWidget {
  const TopNav({
    super.key,
    required this.title,
    required this.showBackButton,
  });

  final String title;
  final bool showBackButton;

  @override
  State<TopNav> createState() => _TopNavState();

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }
}

class _TopNavState extends State<TopNav> {
  late int badgeCount;

  @override
  void initState() {
    super.initState();
    setBadgeCount();
    eventBus.on<RefreshCartEvent>().listen((event) {
      if (mounted) {
        setBadgeCount();
      }
    });
  }

  void setBadgeCount() {
    setState(() {
      badgeCount = getNumberOfProductsInCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: null,
      automaticallyImplyLeading: widget.showBackButton,
      middle: Text(widget.title),
      trailing: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CupertinoButton(
              child: Badge(
                badgeContent: Text(badgeCount.toString()),
                showBadge: productsInCart.isNotEmpty,
                child: const Icon(CupertinoIcons.cart),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const CartScreen()));
              },
            ),
            CupertinoButton(
              child: const Icon(CupertinoIcons.profile_circled),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text(LOGOUT),
                    message: const Text(ARE_YOU_SURE_YOU_WANT_TO_LOGOUT),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(CANCEL),
                      ),
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: EMPTY_STRING),
                            ),
                          );
                        },
                        child: const Text(LOGOUT, style: TextStyle(color: CupertinoColors.systemRed),),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
