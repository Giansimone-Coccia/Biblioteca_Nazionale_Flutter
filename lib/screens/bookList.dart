import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(),
      body: Column(
        children: [
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: WelcomeSection(),
          ),
          Expanded(
            child: BookListView(),
          ),
        ],
      ),
    );
  }
}

final Color customPurpleColor = const Color(0xFF6D77FB);


class CustomAppBarSearch extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Sfondo trasparente
      elevation: 0, // Rimuovi l'ombra dell'AppBar
      toolbarHeight: kToolbarHeight,
      title: SearchView(),
      automaticallyImplyLeading: false, // Nascondi l'icona di andata indietro
    );
  }
}

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customPurpleColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () {
              // Clear search query
            },
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white), // Cambia il colore del testo di input
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
        Text(
          'Welcome',
          style: TextStyle(fontSize: 24),
        ),
        Image.asset(
          'assets/images/best_home_library_apps.png',
          height: 250,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}

class BookListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      children: [
        // List of books
      ],
    );
  }
}


