import 'package:commerce_app/events.dart';
import 'package:commerce_app/globles.dart';
import 'package:commerce_app/product.dart';

void addProductToCart(Product product) {
  if (productsInCart.containsKey(product)) {
    productsInCart[product] = productsInCart[product]! + 1;
  } else {
    productsInCart[product] = 1;
  }
  eventBus.fire(RefreshCartEvent());
}

void removeProductFromCart(Product product) {
  if (productsInCart[product]! > 1) {
    productsInCart[product] = productsInCart[product]! - 1;
  } else {
    productsInCart.remove(product);
  }
  eventBus.fire(RefreshCartEvent());
}

int getNumberOfProductsInCart() {
  int count = 0;
  for (Product key in productsInCart.keys) {
    count += productsInCart[key]!;
  }
  return count;
}

int getCountForProduct(Product product) {
  return productsInCart[product] ?? 0;
}