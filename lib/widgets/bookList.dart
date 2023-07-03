import 'package:bib_nazionale_flutter/widgets/searchResult.dart';
import 'package:flutter/material.dart';
import 'package:google_books_api/google_books_api.dart';

import '../main.dart';
import 'bookInfo.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  String searchQuery = '';
  GoogleApi googleApi = GoogleApi();
  List<Book> bookList = [];
  bool showWelcomeSection = true;
  GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    updateSearchQuery('');
  }

  Future<void> updateSearchQuery(String query) async {
    setState(() {
      searchQuery = query;
    });

    if (query.isNotEmpty) {
      List<Book> books = await googleApi.getListOfBookByName(query);
      setState(() {
        bookList = books;
        showWelcomeSection = false;
      });
    }
  }

  Route _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBarSearch(onSearchChanged: updateSearchQuery),
            body: Center(
              child: showWelcomeSection
                  ? WelcomeSection()
                  : BookListView(books: bookList),
            ),
          ),
        );
      case '/bookInfoPage':
        return MaterialPageRoute(
          builder: (BuildContext context) => BookDetailsPage(
            title: '',
            authors: '',
            description: '',
            image: '',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBarSearch(onSearchChanged: updateSearchQuery),
            body: Center(
              child: showWelcomeSection
                  ? WelcomeSection()
                  : BookListView(books: bookList),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeKey,
      initialRoute: '/homepage',
      onGenerateRoute: _generateRoute,
    );
  }
}

Future<void> navigate(BuildContext context, String route,
        {bool isDialog = false,
        bool isRootNavigator = true,
        Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);

class CustomAppBarSearch extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String) onSearchChanged;

  CustomAppBarSearch({required this.onSearchChanged});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 2.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      title: SearchView(onSearchChanged: onSearchChanged),
      bottom: PreferredSize(
        child: Container(
          color: customPurpleColor,
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
      automaticallyImplyLeading: false,
    );
  }
}

final Color customPurpleColor = const Color(0xFF6D77FB);

class SearchView extends StatefulWidget {
  final Function(String) onSearchChanged;

  SearchView({required this.onSearchChanged});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    if (value.isNotEmpty) {
      widget.onSearchChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customPurpleColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _textEditingController,
        onSubmitted: _handleSubmitted,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () {
              _textEditingController.clear();
            },
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/best_home_library_apps.webp',
          height: 250,
          width: 250,
        ),
        SizedBox(height: 8),
        Text(
          'Welcome to the app of\nBiblioteca Nazionale',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class BookListView extends StatelessWidget {
  final List<Book> books;

  BookListView({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      itemCount: books.length,
      itemBuilder: (context, index) {
        if (index < books.length - 1) {
          Book book = books[index];
          return SearchResult(book: book);
        } else {
          return Container();
        }
      },
    );
  }
}

class GoogleApi {
  GoogleApi();

  Future<List<Book>> getListOfBookByName(String bookName) async {
    List<Book> books = await GoogleBooksApi().searchBooks(
      bookName,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );
    return books;
  }

  Future<Book> getBookById(String idBook) async {
    Book books = await GoogleBooksApi().getBookById(idBook);
    return books;
  }
}
