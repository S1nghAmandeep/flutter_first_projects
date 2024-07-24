import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    String? id,
    // required this.location,
  }) : id = id ?? uuid.v4();

  final String title;
  final File image;
  final String id;
  // final PlaceLocation location;
}

class PlaceLocation {
  PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
  final String address;
}
