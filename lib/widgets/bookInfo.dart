import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../utils/library_api.dart';
import '../utils/search_api.dart';

final Color customPurpleColor = const Color(0xFF6D77FB);

class BookDetailsPage extends StatefulWidget {
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
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  List<String> completeList = [];
  bool _bookExists = false;

  @override
  void initState() {
    super.initState();
    getLibrary(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: customPurpleColor,
        ),
        bottom: PreferredSize(
          child: Container(
            color: customPurpleColor,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BookHeader(
                image: widget.image,
                title: widget.title,
                authors: widget.authors,
              ),
              SizedBox(height: 16.0),
              BookInfo(description: widget.description),
              SizedBox(height: 16.0),
              DropdownMenu(dropdownItems: completeList),
              SizedBox(height: 16.0),
              RequestBookButton(
                onPressed: () async {
                  // Resto del codice...
                },
              ),
              SizedBox(height: 16.0),
              // Resto del codice...
            ],
          ),
        ),
      ),
    );
  }

  void getLibrary(String bookName) async {
    final searchApi = SearchApi();
    final bookId = await searchApi.getBookId(bookName);
    if (bookId != null) {
      final libraryApi = LibraryApi();
      final shelfmarks = await libraryApi.getShelfmarks(bookId);
      if (shelfmarks != null && shelfmarks.isNotEmpty) {
        setState(() {
          completeList = shelfmarks;
          _bookExists = true;
        });
      }
    }
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          image,
          width: 120.0,
          height: 160.0,
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                authors,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookInfo extends StatefulWidget {
  final String description;

  const BookInfo({required this.description});

  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  bool isExpanded = false;

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
            LayoutBuilder(
              builder: (context, constraints) {
                final textSpan = TextSpan(text: widget.description);
                final textPainter = TextPainter(
                  text: textSpan,
                  maxLines: isExpanded ? null : 5,
                  textDirection: TextDirection.ltr,
                );
                textPainter.layout(maxWidth: constraints.maxWidth);
                final textHeight = textPainter.size.height;

                if (textHeight > 5 * DefaultTextStyle.of(context).style.fontSize!) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.description,
                        maxLines: isExpanded ? null : 5,
                        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Read less' : 'Read more',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: customPurpleColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Text(
                    widget.description,
                    maxLines: isExpanded ? null : 5,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenu extends StatefulWidget {
  final List<String> dropdownItems;

  DropdownMenu({required this.dropdownItems});

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available in libraries:',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _selectedItem,
          items: widget.dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class RequestBookButton extends StatelessWidget {
  final VoidCallback onPressed;

  RequestBookButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
