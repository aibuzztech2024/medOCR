import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/widget/donation_read_more_card.dart';
// Adjust this import if the card is in a different file

class DonationCardExamplePage extends StatelessWidget {
  const DonationCardExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample mock data
    final sampleData = DonationCardModel(
      imageUrl:
          'https://img.freepik.com/free-photo/little-girl-with-backpack-studio_23-2147851792.jpg?semt=ais_hybrid&w=740',
      title: 'Help Flood Victims',
      subtitle: 'Urgent Aid Needed',
      distance: '3 km away',
      category: 'Disaster Relief',
      description:
          'Thousands of people have been displaced due to the recent floods. Your donations will go towards food, shelter, and essential supplies. Every contribution counts.',
      websiteUrl: 'https://example.com/donate',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Donation Card Demo')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: DonationCard(data: sampleData),
        ),
      ),
    );
  }
}
