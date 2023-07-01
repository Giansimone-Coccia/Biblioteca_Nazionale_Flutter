import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class MyNavigationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menu(
      items: [
        MenuItem(
          id: 'bookListFragment',
          icon: Icons.home,
          title: 'Home',
        ),
        MenuItem(
          id: 'myBooksFragment',
          icon: Icons.book,
          title: 'Books',
        ),
        MenuItem(
          id: 'myReviewsFragment',
          icon: Icons.rate_review,
          title: 'Reviews',
        ),
        MenuItem(
          id: 'notificationsFragment',
          icon: Icons.notifications,
          title: 'Notifications',
        ),
        MenuItem(
          id: 'profileInfoFragment',
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

  const Menu({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
        );
      }).toList(),
      onTap: (index) {
        // Gestisci l'evento di selezione del menu
        switch (items[index].id) {
          case 'bookListFragment':
          // Azione per la schermata Home
            break;
          case 'myBooksFragment':
          // Azione per la schermata Books
            break;
          case 'myReviewsFragment':
          // Azione per la schermata Reviews
            break;
          case 'notificationsFragment':
          // Azione per la schermata Notifications
            break;
          case 'profileInfoFragment':
          // Azione per la schermata Profile
            break;
        }
      },
    );
  }
}