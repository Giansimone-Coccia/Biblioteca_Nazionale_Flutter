import 'dart:convert';
import 'package:http/http.dart' as http;

class LibraryApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/full.json";

  Future<List<String>?> getShelfmarks(String bookId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?bid=$bookId"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final localizzazioni = jsonData['localizzazioni'];
        List<String> shelfmarks = [];
        for (var localizzazione in localizzazioni) {
          final shelfmarksList = localizzazione['shelfmarks'];
          for (var shelfmarkData in shelfmarksList) {
            final shelfmark = shelfmarkData['shelfmark'];
            shelfmarks.add(shelfmark);
          }
        }
        return shelfmarks;
      } else {
        // Gestione degli errori
        return null;
      }
    } catch (e) {
      // Gestione degli errori
      return null;
    }
  }
}