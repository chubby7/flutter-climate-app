import 'package:geolocator/geolocator.dart';

class Location {
  Location();

  double? latitude;
   double? longitude;


  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permission permanently denied.');
        await Geolocator.openAppSettings();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      // print(position.latitude);
      // print(position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}