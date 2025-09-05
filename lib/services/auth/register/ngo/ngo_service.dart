import 'dart:convert';
import 'package:avatar/models/auth/ngo/ngo_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NgoRepository {
  Future<bool> registerNgo(NgoProfileModel ngoData) async {
    const String baseUrl = "http://122.170.111.109:6184/api/ngo_register/";

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ngoData.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.printInfo(info: "NGO registered successfully");
        return true;
      } else {
        Get.printInfo(info: "Registration failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      Get.printInfo(info: "HTTP error during registration: $e");
      return false;
    }
  }
}
