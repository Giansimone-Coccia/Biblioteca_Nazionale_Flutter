import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BookHeader(),
              SizedBox(height: 16.0),
              BookInfo(),
              SizedBox(height: 16.0),
              BookActions(),
              SizedBox(height: 16.0),
              SimilarBooks(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/book_cover.jpg',
              width: 200.0,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Book Title',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Author Name',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the Book',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Price: \$19.99',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class BookActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star_half,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.amber,
                ),
                Text('4.5 (30,987)'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle book review button press
              },
              child: Text('Write a Review'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle share button press
              },
              child: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimilarBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Similar Books',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  'assets/images/book1.jpg',
                  width: 150.0,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(width: 16.0),
                Image.asset(
                  'assets/images/book2.jpg',
                  width: 150.0,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(width: 16.0),
                Image.asset(
                  'assets/images/book3.jpg',
                  width: 150.0,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        ],
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
      home: BookDetailsPage(),
    );
  }
}
