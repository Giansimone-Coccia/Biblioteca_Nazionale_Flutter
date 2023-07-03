import 'dart:convert';
import 'package:http/http.dart' as http;

class LibraryApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/full.json";

  Future<List<String>?> getShelfmarks(List<String?> bookIds) async {
    try {
      final List<String> shelfmarks = [];
      for (var bookId in bookIds) {
        final response = await http.get(Uri.parse("$baseUrl?bid=$bookId"));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final localizzazioni = jsonData['localizzazioni'];
          for (var localizzazione in localizzazioni) {
            final shelfmarksList = localizzazione['shelfmarks'];
            for (var shelfmarkData in shelfmarksList) {
              final shelfmark = shelfmarkData['shelfmark'];
              shelfmarks.add(shelfmark);
            }
          }
        } else {
          return null;
        }
      }
      return shelfmarks;
    } catch (e) {
      // Gestione degli errori
      return null;
    }
  }
}
