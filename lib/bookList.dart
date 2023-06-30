import 'package:flutter/material.dart';

class MaterialToolbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final List<Widget> actions;
  final Widget bottom;

  const MaterialToolbar({
    Key? key,
    required this.backgroundColor,
    required this.actions,
    required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: actions,
            ),
            if (bottom != null) bottom,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

class BookListFragment extends StatelessWidget {
  final List<Book> books = [
    Book(title: 'Book 1', author: 'Author 1'),
    Book(title: 'Book 2', author: 'Author 2'),
    Book(title: 'Book 3', author: 'Author 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/search_layout.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: MaterialToolbar(
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search button click
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/search_bar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.close),
                    ),
                    onSubmitted: (query) {
                      // Handle search query submission
                    },
                    onChanged: (query) {
                      // Handle search query change
                    },
                  ),
                ),
              ),
            ),
          ),
          const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.grey,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/best_home_library_apps.png',
                  fit: BoxFit.fitWidth,
                  height: 250,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        onTap: () {
                          // Handle book item click
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BookListFragment(),
  ));
}
