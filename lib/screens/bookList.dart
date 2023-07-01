import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarSearch(),
      body: Column(
        children: [
          /*LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.transparent,
          ),*/ //TODO LUCA: abilitarla quando si fa la ricerca del libro !
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

class CustomAppBarSearch extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // Sfondo trasparente
      elevation: 0,
      // Rimuovi l'ombra dell'AppBar
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
        style: TextStyle(
            color: Colors.white), // Cambia il colore del testo di input
      ),
    );
  }
}

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/best_home_library_apps.webp',
            height: 250,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: EdgeInsets.all(16.0), // Aggiunge il padding desiderato
            child: Center(
              child: Text(
                'Welcome to the app of\nBiblioteca Nazionale',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center, // Centra il testo
              ),
            ),
          ),
        ],
      ),
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
