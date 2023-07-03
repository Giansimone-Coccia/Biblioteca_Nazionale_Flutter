import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../models/DatabaseProvider.dart';
import '../models/dbbooks.dart';
import 'bookDelete.dart';

DatabaseProvider _databaseProvider = DatabaseProvider();

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> with WidgetsBindingObserver {
  late BooksProvider _booksProvider;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _booksProvider = Provider.of<BooksProvider>(context, listen: false);
    _booksProvider.addListener(updateBooks);
    fetchBooks();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    _booksProvider.removeListener(updateBooks);
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void updateBooks() {
    if (_hasFocus) {
      setState(() {});
    }
  }

  Future<void> fetchBooks() async {
    await _booksProvider.fetchBooks();
  }

  Future<void> refreshBooks() async {
    await _booksProvider.fetchBooks();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _hasFocus = state == AppLifecycleState.resumed;
    if (_hasFocus) {
      refreshBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Books",
          style: TextStyle(
            color: customPurpleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: customPurpleColor,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: refreshBooks,
        child: Consumer<BooksProvider>(
          builder: (context, booksProvider, _) {
            if (booksProvider.books.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/libraryBanner1.svg',
                      width: 250,
                      height: 250,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'No books found',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: booksProvider.books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToBookDeletePage(
                          booksProvider.books[index], context);
                    },
                    child: BookItem(book: booksProvider.books[index]),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshBooks,
        child: Icon(Icons.refresh),
        backgroundColor: customPurpleColor,
      ),
    );
  }

  void _navigateToBookDeletePage(DBBook book, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDeletePage(
          book: book,
        ),
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final DBBook book;

  const BookItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              book.image,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Authors: ${book.authors}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Id: ${book.id}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksProvider extends ChangeNotifier {
  List<DBBook> _books = [];

  List<DBBook> get books => _books;

  Future<void> fetchBooks() async {
    List<DBBook> books = await _databaseProvider.getAllBooks();
    _books = books;
    notifyListeners();
  }

  void addBook(DBBook book) {
    _books.add(book);
    notifyListeners();
  }

  void removeBook(DBBook book) {
    _books.remove(book);
    notifyListeners();
  }
}
