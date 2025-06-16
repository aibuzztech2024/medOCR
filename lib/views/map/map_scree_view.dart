import 'package:avatar/viewModels/map/location_controller.dart';
import 'package:avatar/views/map/widgets/draggable_bottom_sheet.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class MapScree extends StatefulWidget {
  const MapScree({super.key});

  @override
  State<MapScree> createState() => _MapScreeState();
}

class _MapScreeState extends State<MapScree> {
  final locationController = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    locationController.requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!locationController.isLocationPermissionGranted.value ||
            locationController.currentLatLng.value == null) {
          return const Center(child: CupertinoActivityIndicator());
        }

        final userLocation = locationController.currentLatLng.value!;

        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(255, 111, 97, 1),
          ),
          child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  FlutterMap(
                    mapController: locationController.mapController,
                    options: MapOptions(
                      initialCenter: userLocation, // LatLng
                      initialZoom: 18,
                      onMapReady: () => Get.log("Map is ready"),
                      maxZoom: 21,
                      minZoom: 1,
                    ),
                    children: [
                      // Map
                      TileLayer(urlTemplate: locationController.mapUrl),
                      // User location marker
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation,
                            width: 40,
                            height: 40,
                            child: AvatarGlow(
                              glowRadiusFactor: 1,
                              glowColor: context.theme.primaryColorDark,
                              child: Icon(
                                CupertinoIcons.location_north_fill,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: SafeArea(
                      child: IconButton.outlined(
                        onPressed: locationController.recenter,
                        icon: Icon(Icons.my_location),
                      ),
                    ),
                  ),
                  DraggableBottomSheet(),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
