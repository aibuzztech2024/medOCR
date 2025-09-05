import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/maps/json_data_model.dart';

class LocationService {
  static const String _baseUrl = 'https://photon.komoot.io/api/';

  Future<JsonDataModel> searchLocations(String query) async {
    try {
      // URL encode the query to handle special characters
      final encodedQuery = Uri.encodeComponent(query);
      final url = '$_baseUrl?q=$encodedQuery&limit=2';

      print('Searching with URL: $url'); // Debug log

      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Parsed JSON: $jsonData'); // Debug log

        final result = JsonDataModel.fromJson(jsonData);
        print(
          'Number of results: ${result.features?.length ?? 0}',
        ); // Debug log
        return result;
      } else {
        throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in searchLocations: $e'); // Debug log
      throw Exception('Error searching locations: $e');
    }
  }
}
