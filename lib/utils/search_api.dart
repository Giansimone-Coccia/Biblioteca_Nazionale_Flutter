import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/search.json";

  Future<String?> getBookId(String bookName) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?any=$bookName"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final firstResult = jsonData['briefRecords'][0];
        final bookId = firstResult['codiceIdentificativo'];
        return bookId;
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
