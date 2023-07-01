import 'package:google_books_api/google_books_api.dart';

class GoogleApi{
    // Costruttore
    GoogleApi();


    Future<List<Book>> getListOfBookByName(String bookName) async {
      List<Book> books = await GoogleBooksApi().searchBooks(
        bookName,
        //maxResults: 20,
        printType: PrintType.books,
        orderBy: OrderBy.relevance,
      );
      return books;
    }


    Future<Book> getBookById(String idBook) async{
        Book books = await GoogleBooksApi().getBookById(idBook);
        return books;
    }


}