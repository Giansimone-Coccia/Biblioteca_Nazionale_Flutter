import 'dart:convert';
import 'package:http/http.dart' as http;

class LibraryApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/full.json";

  Future<List<String>?> getShelfmarks(List<String?> bookIds) async {
    final List<String> shelfmarks = [];

    try {

      for (var bookId in bookIds) {
        if (bookId != null) {
          final url = Uri.parse("$baseUrl?bid=$bookId");
          final response = await http.get(url);

          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            final localizzazioni = jsonData['localizzazioni'] as List<dynamic>;

            for (var localizzazione in localizzazioni) {
              final shelfmarksList = localizzazione['shelfmarks'] as List<dynamic>;


              for (var shelfmarkData in shelfmarksList) {
                final shelfmark = shelfmarkData['shelfmark'] as String;
                shelfmarks.add(shelfmark);
              }
              print("shelfmarks:$shelfmarks");
            }
          } else {
            print("Errore getShelfmarks: ${response.statusCode}");
            return null;
          }
        }
      }

      return shelfmarks;
    } catch (e) {
      print(e);
      print("Errore getShelfmarks fallito");
      // Gestione degli errori
      return shelfmarks;
    }
  }
}
