import 'package:flutter/material.dart';
import '../models/DatabaseProvider.dart';
import '../models/dbbooks.dart';
import '../widgets/bookDelete.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  List<DBBook> _books = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    List<DBBook> books = await _databaseProvider.getAllBooks();

    setState(() {
      _books = books;
    });
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

      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToBookDeletePage(_books[index]);
            },
            child: BookItem(book: _books[index]),
          );
        },
      ),
    );
  }

  void _navigateToBookDeletePage(DBBook book) {
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
