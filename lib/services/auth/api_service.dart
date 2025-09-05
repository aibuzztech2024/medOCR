// File: lib/services/client_api_service.dart
import 'dart:convert';
import 'package:avatar/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientApiService {
  static const String baseUrl =
      'http://192.168.1.100:8018/api/client_register/'; // Replace with your actual API URL

  static Future<void> testClientRegistration() async {
    // Hardcoded test data as provided
    final Map<String, dynamic> testData = {
      "email": "clin7412@gmail.com",
      "phone-number1": "9876543210",
      "company-name": "ClientCorp Pvt Ltd",
      "services-intrested": "Advertising, Analytics",
      "website-url": "https://clientcorp.com",
      "address": "789 Client Street",
      "dist": "Chennai",
      "pincode": "600001",
      "state": "Tamil Nadu",
      "country": "India",
      "latitude": "13.0827",
      "longitude": "80.2707",
      "incorporation-doc": "client_doc.pdf",
      "gst-number": "GSTCLIENT125",
      "pan-number": "PANCLIENT185",
      "tan-number": "TANCLIENT456",
      "password": "ClientPass@2222",
      "contact-name": "Sneha Verma",
      "contact-role": "Head of Operations",
      "phone-number2": "9871234567",
      "referral-code": "REFCLIENT001",
    };

    try {
      print('🚀 Making API call to register client...');
      print('📤 Request Body: ${jsonEncode(testData)}');

      // Make the API call
      final response = await http.post(
        Uri.parse(
          ApiConstants.clientRegisterEndpoint,
        ), // Test endpoint - replace with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(testData),
      );

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Show success message
        Get.snackbar(
          '✅ API Test Successful',
          'Client registration API is working!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
        );

        // Show detailed response
        Get.dialog(
          AlertDialog(
            title: Text('🎉 API Response'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Status: ${response.statusCode}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Response:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      jsonEncode(responseData),
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Close')),
            ],
          ),
        );
      } else {
        // Show error message
        Get.snackbar(
          '❌ API Test Failed',
          'Status Code: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
        );
      }
    } catch (e) {
      print('🚨 API Call Error: $e');

      // Show error message
      Get.snackbar(
        '🚨 Network Error',
        'Failed to connect: $e',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    }
  }
}
