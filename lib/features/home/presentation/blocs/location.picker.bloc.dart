import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/utils/location.helper.dart';

class LocationPickerBloc extends ChangeNotifier {
  static const String PICKED_POSITION_ID = "PICKED_POSITION_ID";

  LocationHelper _locationHelper;
  GoogleMapController _mapController;
  StreamSubscription _locationSubscription;

  LocationData locationData;
  LatLng pickedPosition;
  CameraPosition cameraPosition;
  Set<Marker> markers = {};
  TextEditingController locationTextController;

  LocationPickerBloc() {
    locationTextController = TextEditingController();
    _locationHelper = LocationHelper();
    cameraPosition = CameraPosition(target: LatLng(20, 20), zoom: 11);
    _locationSubscription =
        _locationHelper.streamLocation.listen((_locationData) {
      locationData = _locationData;
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  void requestLocationAccess() => _locationHelper.requestLocation();

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (pickedPosition == null)
      setCameraPositionToMyLocation();
    else
      setCameraPosition(pickedPosition);
    _drawMarker();
    notifyListeners();
  }

  void setCameraPositionToMyLocation() {
    requestLocationAccess();
    final myPosition =
        LatLng(locationData?.latitude ?? 0, locationData?.longitude ?? 0);
    locationTextController.text = myPosition.toString();
    _mapController.animateCamera(CameraUpdate.newLatLng(myPosition));
  }

  void setCameraPosition(LatLng position) {
    _mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  void onCameraMove(CameraPosition cameraPosition) {
    pickedPosition = cameraPosition.target;
    _drawMarker();
    locationTextController.text = cameraPosition.target.toString();
    notifyListeners();
  }

  void _drawMarker() {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(PICKED_POSITION_ID),
        position: pickedPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }
}
