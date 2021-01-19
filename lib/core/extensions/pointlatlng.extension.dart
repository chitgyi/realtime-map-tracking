import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension PointLatLngExtension on PointLatLng {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension LatLngExtension on LatLng {
  PointLatLng toPointLatLng() => PointLatLng(latitude, longitude);
}

extension LatLngListExtension on List<PointLatLng> {
  List<LatLng> toLatLngList() => this.map((e) => e.toLatLng()).toList();
}

extension PointLatLngListExtension on List<LatLng> {
  List<PointLatLng> toLatLngList() =>
      this.map((e) => e.toPointLatLng()).toList();
}
