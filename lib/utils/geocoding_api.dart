import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingApi {
  final String baseUrl = "https://maps.googleapis.com/maps/api/geocode/json";
  final String apiKey = "AIzaSyCtTj2ohggFHtNX2asYNXL1kj31pO8wO_Y";

  Future<Map<String, double>?> getCoordinates(String libraryName) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?address=$libraryName&key=$apiKey"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['results'];
        if (results.isNotEmpty) {
          final location = results[0]['geometry']['location'];
          final latitude = location['lat'];
          final longitude = location['lng'];
          return {'latitude': latitude, 'longitude': longitude};
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}