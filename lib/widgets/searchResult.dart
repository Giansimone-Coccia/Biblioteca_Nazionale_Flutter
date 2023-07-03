import 'package:flutter/material.dart';
import 'package:google_books_api/google_books_api.dart';
import 'bookInfo.dart';

import '../screens/homepage.dart';
import 'bookInfo.dart';
import 'bookList.dart';

class SearchResult extends StatelessWidget {
  final Book book;

  SearchResult({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookDetailsPage(title: book.volumeInfo.title,
                    authors: book.volumeInfo.authors.isNotEmpty
                        ? book.volumeInfo.authors[0]
                        : "No author found",
                    description
                        : book.volumeInfo != null &&
                        book.volumeInfo.description.isNotEmpty
                        ? book.volumeInfo.description
                        : "No description found",
                    image
                    :  book.volumeInfo.imageLinks!["thumbnail"].toString()),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 160,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: book.volumeInfo.imageLinks != null
                      ? Image.network(
                    book.volumeInfo.imageLinks!["thumbnail"].toString(),
                    fit: BoxFit.fitHeight,
                  )
                      : Icon(
                    Icons.image,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.volumeInfo.title,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book.volumeInfo.authors.isNotEmpty
                          ? book.volumeInfo.authors[0]
                          : "No author found",
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    /*Row(
                    children: [
                       RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRing: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        '0.0 (0)',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),*/
                    Text(
                      book.volumeInfo.description.isNotEmpty
                          ? book.volumeInfo.description
                          : "No description found",
                      style: TextStyle(fontSize: 14),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
