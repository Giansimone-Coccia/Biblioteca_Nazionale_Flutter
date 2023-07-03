import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/DatabaseProvider.dart';
import '../models/dbbooks.dart';
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
  List<Marker> markerList = [];
  String library = "";
  String _message = '';
  bool _bookExists = false;
  DatabaseProvider _databaseProvider = DatabaseProvider();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await getLibrary(widget.title);
    addMarkersToMap();
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
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GoogleMap(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(41.87194, 12.56738),
                      zoom: 5,
                    ),
                    markers: Set<Marker>.from(markerList),
                  ),
                ) // Indicatore di caricamento
              ),
              SizedBox(height: 16.0),
              Text(library),
              SizedBox(height: 16.0),
              RequestBookButton(
                onPressed: () async {
                  DBBook book = DBBook(
                    title: widget.title,
                    authors: widget.authors,
                    image: widget.image,
                    description: widget.description,
                    library: library,
                  );
                  try {
                    bool bookExists = await _databaseProvider.checkBookExists(book);
                    if (bookExists) {
                      setState(() {
                        _bookExists = true;
                        _message = 'Book already exists!';
                      });
                    } else {
                      await _databaseProvider.addBook(book);
                      setState(() {
                        _bookExists = false;
                        _message = 'Book successfully requested!';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _message = 'Failed to request book. Please try again.';
                    });
                  }
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

  Future<List<String>> getLibrary(String bookName) async {
    final searchApi = SearchApi();
    final bookId = await searchApi.getBookId(bookName);
    print(bookId);
    if (bookId != null) {
      final libraryApi = LibraryApi();
      final shelfmarks = await libraryApi.getShelfmarks(bookId);
      if (shelfmarks != null && shelfmarks.isNotEmpty) {
        Set<String> set = Set<String>.from(shelfmarks);
        List<String> shelfmarksMulti = shelfmarks.toList();

        for (String libraryName in shelfmarks) {
          final apiKey = 'AIzaSyCtTj2ohggFHtNX2asYNXL1kj31pO8wO_Y'; // Sostituisci con la tua chiave API
          final encodedLibraryName = Uri.encodeQueryComponent(libraryName);
          final url =
              'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedLibraryName&key=$apiKey';

          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['status'] == 'OK') {
              final results = data['results'] as List<dynamic>;
              if (results.isNotEmpty) {
                final location = results[0]['geometry']['location'];
                final latitude = location['lat'];
                final longitude = location['lng'];

                setState(() {
                  markerList.add(
                    Marker(
                      markerId: MarkerId(libraryName),
                      position: LatLng(latitude, longitude),
                      onTap: () {
                        setState(() {
                          library = libraryName;
                        });
                      },
                      infoWindow: InfoWindow(
                        title: libraryName,
                      ),
                    ),
                  );
                });
              }
            }
          }
        }

        setState(() {
          completeList = shelfmarksMulti;
          _bookExists = true;
        });
        return shelfmarksMulti;
      }
    }
    return [];
  }

  void addMarkersToMap() async {

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

                if (textHeight >
                    5 * DefaultTextStyle.of(context).style.fontSize!) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.description,
                        maxLines: isExpanded ? null : 5,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
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
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
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
