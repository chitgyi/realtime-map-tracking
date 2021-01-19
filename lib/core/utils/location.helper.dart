import 'package:location/location.dart';

class LocationHelper {
  final Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  void requestLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Stream<LocationData> get streamLocation => location.onLocationChanged;

  bool get hasAccessLocation => _serviceEnabled ?? false;

  bool get hasGrantedLocation =>
      _permissionGranted == PermissionStatus.granted ?? false;
}
