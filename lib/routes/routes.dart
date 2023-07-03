import 'package:bib_nazionale_flutter/models/dbbooks.dart';
import 'package:bib_nazionale_flutter/screens/my_books.dart';
import 'package:bib_nazionale_flutter/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_books_api/google_books_api.dart';
import '../main.dart';
import '../screens/homepage.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../widgets/bookDelete.dart';
import '../widgets/bookInfo.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String homepage = '/homepage';
  static const String profile = '/profile';
  static const String bookInfo = '/bookeInfoPage';
  static const String myBooks = '/myBooks';
  static const String deleteBook = '/deleteBooks';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case registration:
        return MaterialPageRoute(builder: (_) => Register());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case profile:
        return MaterialPageRoute(builder: (_) => Profile());
      case bookInfo:
        return MaterialPageRoute(builder: (_) => BookDetailsPage(title: '', authors: '', description: '', image: '',));
      case myBooks:
        return MaterialPageRoute(builder: (_) => MyBooks());
      case deleteBook:
        return MaterialPageRoute(builder: (_) => BookDeletePage(book: DBBook(id:1, title: '', authors: '', description: '', image: ''),));
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('Route not found'),
                ),
              ),
        );
    }
  }
}
