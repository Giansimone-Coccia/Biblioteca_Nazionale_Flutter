import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchApi {
  final String baseUrl = "http://opac.sbn.it/opacmobilegw/search.json";

  Future<List<String?>> getBookId(String bookName) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?any=$bookName"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['briefRecords'];
        final List<String> bookIds = [] ;
        for(var result in results){
          bookIds.add(result['codiceIdentificativo']);
        }
        return bookIds;
      } else {
        // Gestione degli errori
      }
    } catch (e) {
      // Gestione degli errori
    }
    return [];
  }
}
