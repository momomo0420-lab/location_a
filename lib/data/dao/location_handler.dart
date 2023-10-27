import 'package:geolocator/geolocator.dart';

abstract class LocationHandler {
  Future<Position?> getCurrentPosition();
}
