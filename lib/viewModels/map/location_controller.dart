import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationController extends GetxController {
  /// Tracks if we can proceed after getting location permission
  final RxBool isLocationPermissionGranted = false.obs;
  final String mapUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  final MapControllerImpl mapController = MapControllerImpl();
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  var currentAccuracyRadius = 0.0.obs;
  late Stream<Position> _positionStream;
  var headingDegree = 0.0.obs;

  /// Handles location permission logic with all cases
  Future<void> requestLocationPermission() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Service Disabled",
        "Please enable location services to continue.",
        snackPosition: SnackPosition.BOTTOM,
      );
      isLocationPermissionGranted.value = false;
      return;
    }

    // Check current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission if not granted
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required to proceed.",
          snackPosition: SnackPosition.BOTTOM,
        );
        isLocationPermissionGranted.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Permanently Denied",
        "Please enable location permission from settings.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 4),
        mainButton: TextButton(
          onPressed: Geolocator.openAppSettings,
          child: AppText("Open Settings"),
        ),
      );
      isLocationPermissionGranted.value = false;
      return;
    }

    var position = await getPosition();
    currentLatLng.value = LatLng(position.latitude, position.longitude);
    getHeading();

    // ✅ Permission granted
    isLocationPermissionGranted.value = true;
  }

  /// User current position
  Future<Position> getPosition() async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5, // update every 5 meters
      ),
    );

    _positionStream.listen((Position position) {
      //currentPosition.value = position;
      currentLatLng.value = LatLng(position.latitude, position.longitude);
      currentAccuracyRadius.value = position.accuracy; // accuracy in meters
    });
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Recenter
  void recenter({double? degreeOfRotation}) {
    mapController.moveAndRotateAnimatedRaw(
      currentLatLng.value!,
      19.0, // Zoom
      // This degree can be passed if wants to recenter as per user heading
      degreeOfRotation ?? 0.0, // degree
      offset: Offset.zero,
      duration: Durations.long4,
      curve: Curves.easeOut,
      hasGesture: false,
      source: MapEventSource.custom,
    );
  }

  void getHeading() {
    FlutterCompass.events?.listen((CompassEvent event) {
      final double? heading = event.heading; // degrees from North
      if (heading != null) {
        headingDegree.value = heading;
      }
    });
  }
}
