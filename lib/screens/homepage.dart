import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'bookList.dart';

/*
class MyTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Applica il tema personalizzato lightTheme
      // altre configurazioni dell'app
    );
  }
}
*/

class HomePage extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
          toolbarHeight: kToolbarHeight,
          title: SearchView(),
        ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/icon_layout.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: MyNavigationMenu(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyNavigationMenu extends StatefulWidget {
  @override
  _MyNavigationMenuState createState() => _MyNavigationMenuState();
}

class _MyNavigationMenuState extends State<MyNavigationMenu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Menu(
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        MenuItem(
          id: 'bookList',
          icon: Icons.home,
          title: 'Home',
        ),
        MenuItem(
          id: 'myBooks',
          icon: Icons.book,
          title: 'Books',
        ),
        MenuItem(
          id: 'myReviews',
          icon: Icons.rate_review,
          title: 'Reviews',
        ),
        MenuItem(
          id: 'notifications',
          icon: Icons.notifications,
          title: 'Notifications',
        ),
        MenuItem(
          id: 'profileInfo',
          icon: Icons.person,
          title: 'Profile',
        ),
      ],
    );
  }
}

class MenuItem {
  final String id;
  final IconData icon;
  final String title;

  const MenuItem({
    required this.id,
    required this.icon,
    required this.title,
  });
}

class Menu extends StatelessWidget {
  final List<MenuItem> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const Menu({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(
            item.icon,
            color: Theme.of(context).primaryColor, // Imposta il colore primario del tema per l'icona
          ),
          label: selectedIndex == items.indexOf(item) ? item.title : '',
        );
      }).toList(),
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: selectedIndex,
      onTap: onItemSelected,
    );
  }
}


