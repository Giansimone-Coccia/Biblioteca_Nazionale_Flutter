import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customPurpleColor,
      toolbarHeight: kToolbarHeight,
      title: SearchView(),
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

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Clear search query
            },
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
