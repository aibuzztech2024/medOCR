import 'dart:convert';
import 'package:avatar/models/auth/ngo_model.dart';
import 'package:http/http.dart' as http;

class NgoRepository {
  Future<NgoProfileModel?> fetchNgoProfile() async {
    const String baseUrl = "http://122.170.111.109:6184/api/ngo_register/";

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);

            if (data.isNotEmpty) {
              return NgoProfileModel.fromJson(data);
            } else {
              print("Empty JSON object received");
              return null;
            }
          } catch (e) {
            print("JSON parsing error: $e");
            return null;
          }
        } else {
          print("Empty response body");
          return null;
        }
      } else {
        print(
          "Failed to fetch NGO profile. Status code: ${response.statusCode}",
        );
        return null;
      }
    } catch (e) {
      print("HTTP error: $e");
      return null;
    }
  }
}
