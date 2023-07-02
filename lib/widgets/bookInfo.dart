import 'package:flutter/material.dart';

final Color customPurpleColor = const Color(0xFF6D77FB);

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String authors;
  final String description;
  final String image;

  const BookDetailsPage({
    required this.title,
    required this.authors,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text('Book Details'),
        backgroundColor: customPurpleColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BookHeader(image: this.image, title: this.title, authors: this.authors),
              SizedBox(height: 16.0),
              BookInfo(description: this.description),
              SizedBox(height: 16.0),
              RequestBookButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookHeader extends StatelessWidget {
  final String image;
  final String title;
  final String authors;

  const BookHeader({
    required this.image,
    required this.title,
    required this.authors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              image,
              width: 200.0,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                authors,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  final String description;

  const BookInfo({required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'About the Book',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class RequestBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle request book button press
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: customPurpleColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Text(
          'Request Book',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

class CustomMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Colors.grey,
      child: Center(
        child: Text(
          'Map View',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(BookDetailsApp());
}

class BookDetailsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookDetailsPage(
        title: 'Titolo del libro',
        authors: 'Nome degli autori',
        description: 'Descrizione del libro',
        image: 'a',
      ),
    );
  }
}
 */



