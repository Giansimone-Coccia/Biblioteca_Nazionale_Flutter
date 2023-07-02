import 'package:flutter/material.dart';

import 'bookInfo.dart';

final Color customPurpleColor = const Color(0xFF6D77FB);

class BookDeletePage extends StatelessWidget {
  final String title;
  final String authors;
  final String description;
  final String image;

  const BookDeletePage({
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
              BookHeader(
                  image: this.image, title: this.title, authors: this.authors),
              SizedBox(height: 16.0),
              BookInfo(description: this.description),
              SizedBox(height: 16.0),
              DeleteBookButton(),
            ],
          ),
        ),
      ),
    );
  }
}



class DeleteBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content:
                  Text('Are you sure to remove the book from the booked list?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    // Chiude il popUp
                    Navigator.of(context).pop();
                    // Chiude lo screen di eliminazione del libro(BookDeletePage)
                    // TODO per GIANSIMONE: Prima del pop va tutta la logica per eliminare il libro
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
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
          'Delete Book',
          style: TextStyle(fontSize: 18.0),
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
      home: BookDeletePage(
        title: 'Titolo del libro',
        authors: 'Nome degli autori',
        description: 'Descrizione del libro',
        image: 'a',
      ),
    );
  }
}
 */


