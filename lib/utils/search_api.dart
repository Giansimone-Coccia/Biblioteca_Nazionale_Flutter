import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/search.json";

  Future<List<String>> getBookId(String bookName) async {
    try {
      final url = Uri.parse("$baseUrl?any=${Uri.encodeQueryComponent(bookName)}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final results = jsonData['briefRecords'] as List<dynamic>;
        final bookIds = results.map((result) => result['codiceIdentificativo'] as String).toList();
        print('bookIds: $bookIds');
        return bookIds;
      } else {
        // Gestione degli errori
      }
    } catch (e) {
      print(e);
      print("Errore getBookId fallito");
    }

    return [];
  }
}

