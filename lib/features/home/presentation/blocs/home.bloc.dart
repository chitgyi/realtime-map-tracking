import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/constants/api.constants.dart';
import '../../../../core/extensions/pointlatlng.extension.dart';
import '../../../../core/utils/location.helper.dart';

class HomeBloc extends ChangeNotifier {
  static const SOURCE_ID = 'SOURCE_ID';
  static const DESTINATION_ID = 'DESTINATION_ID';
  static const POLYLINE_ID = 'POLYLINE_ID';

  LocationHelper _locationHelper;
  GoogleMapController _mapController;
  StreamSubscription _locationSubscription;

  LocationData locationData;
  CameraPosition cameraPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  TextEditingController sourceTextController;
  TextEditingController destinationTextController;
  LatLng sourcePosition;
  LatLng destinationPosition;

  HomeBloc() {
    sourceTextController = TextEditingController();
    destinationTextController = TextEditingController();
    _locationHelper = LocationHelper();
    cameraPosition = CameraPosition(target: LatLng(20, 20), zoom: 11);
    _locationSubscription =
        _locationHelper.streamLocation.listen((_locationData) {
      locationData = _locationData;
    });
  }

  @override
  void dispose() {
    print("dispose");
    _locationSubscription.cancel();
    super.dispose();
  }

  void requestLocationAccess() => _locationHelper.requestLocation();

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    final currentPosition =
        LatLng(locationData?.latitude ?? 0, locationData?.longitude ?? 0);
    setCameraPosition(currentPosition);
    sourceTextController.text = currentPosition.toString();
    notifyListeners();
  }

  void setCameraPosition(LatLng position) {
    _mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  void setCameraPositionToMyLocation() {
    _locationHelper.requestLocation();
    final myPosition =
        LatLng(locationData?.latitude ?? 0, locationData?.longitude ?? 0);
    _mapController.animateCamera(CameraUpdate.newLatLng(myPosition));
  }

  void drawPolylinesAndMarkers() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ApiContants.GOOGLE_API_KEY,
      sourcePosition.toPointLatLng(),
      destinationPosition.toPointLatLng(),
    );
    markers.clear();
    polylines.clear();
    markers.addAll([
      Marker(markerId: MarkerId(SOURCE_ID), position: sourcePosition),
      Marker(
          markerId: MarkerId(DESTINATION_ID),
          position: destinationPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange))
    ]);
    polylines.add(Polyline(
      polylineId: PolylineId(POLYLINE_ID),
      points: result.points.toLatLngList(),
    ));
    notifyListeners();
  }
}
