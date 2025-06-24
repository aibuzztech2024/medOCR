import 'package:flutter/material.dart';
import 'location_item.dart';
import 'current_location_item.dart';
import 'more_history_button.dart';

class DefaultLocationsList extends StatelessWidget {
  final VoidCallback onCurrentLocationTap;
  final VoidCallback onMoreHistoryTap;
  final List<Map<String, String>> defaultLocations;
  final Function(String, String) onLocationTap;

  const DefaultLocationsList({
    Key? key,
    required this.onCurrentLocationTap,
    required this.onMoreHistoryTap,
    required this.defaultLocations,
    required this.onLocationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        // Current Location
        CurrentLocationItem(onTap: onCurrentLocationTap),

        Divider(height: 1, thickness: 1, color: Colors.grey[300]),

        // Default locations
        ...defaultLocations.map((location) {
          return Column(
            children: [
              LocationItem(
                title: location['title'] ?? '',
                subtitle: location['subtitle'] ?? '',
                onTap:
                    () => onLocationTap(
                      location['title'] ?? '',
                      location['subtitle'] ?? '',
                    ),
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            ],
          );
        }).toList(),

        // More from recent history button
        MoreHistoryButton(onPressed: onMoreHistoryTap),
      ],
    );
  }
}
