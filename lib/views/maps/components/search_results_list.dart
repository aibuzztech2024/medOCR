import 'package:flutter/material.dart';
import 'location_item.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> results;
  final Function(String, String) onLocationSelected;
  final bool isStartLocation;

  const SearchResultsList({
    Key? key,
    required this.results,
    required this.onLocationSelected,
    required this.isStartLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final location = results[index];
        final properties = location.properties;

        // Build the subtitle with available location details
        final List<String> locationDetails = [];
        if (properties?.name != null) locationDetails.add(properties!.name!);
        if (properties?.city != null) locationDetails.add(properties!.city!);
        if (properties?.state != null) locationDetails.add(properties!.state!);
        if (properties?.country != null)
          locationDetails.add(properties!.country!);

        return Column(
          children: [
            LocationItem(
              title: properties?.name ?? 'Unknown Location',
              subtitle: locationDetails.join(', '),
              onTap:
                  () => onLocationSelected(
                    properties?.name ?? '',
                    locationDetails.join(', '),
                  ),
            ),
            if (index < results.length - 1)
              Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ],
        );
      },
    );
  }
}
