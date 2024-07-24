import 'package:commerce_app/product.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';

List<Product> electronicsProduct = [];
List<Product> jeweleryProduct = [];
List<Product> mensClothingProduct = [];
List<Product> womensClothingProduct = [];
List<GestureDetector> electronicsImages = [];
List<GestureDetector> jeweleryImages = [];
List<GestureDetector> mensClothingImages = [];
List<GestureDetector> womensClothingImages = [];


Map<Product, int> productsInCart = {};

EventBus eventBus = EventBus();