import 'package:bib_nazionale_flutter/screens/my_books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';

final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BooksProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Nazionale',
      theme: ThemeData(
        primaryColor: const Color(0xFF6D77FB),
        backgroundColor: Colors.white,
        // ...definisci altri colori personalizzati qui...
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundImage(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppLogo(primaryColor: primaryColor),
                const SizedBox(height: 16),
                const AppTitle(),
                const SizedBox(height: 16),
                AppButton(
                  buttonText: 'Accedi',
                  primaryColor: primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                const SizedBox(height: 16),
                AppButton(
                  buttonText: 'Registrati',
                  primaryColor: primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/welcome_background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, required this.primaryColor}) : super(key: key);

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      radius: 80,
      child: Icon(
        Icons.menu_book_rounded,
        size: 80,
        color: Colors.white,
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Biblioteca Nazionale',
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonText,
    required this.primaryColor,
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final Color primaryColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: primaryColor,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
