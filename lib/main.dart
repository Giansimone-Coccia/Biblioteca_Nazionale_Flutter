import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF6D77FB),
        // Imposta il colore primario come #6D77FB
        backgroundColor: Colors
            .white, // Imposta il colore di sfondo del contesto come bianco
        // ...definisci altri colori personalizzati qui...
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/login': (context) => Login(),
        '/registration': (context) => Register(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Theme.of(context)
          .backgroundColor, // Imposta il colore di sfondo del contesto
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                // Inserisci il percorso dell'immagine di sfondo
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_welcome.png',
                  // Inserisci il percorso dell'immagine da posizionare sopra i pulsanti
                  width: 200,
                ),
                SizedBox(height: 16),
                // Aggiunto uno spazio vuoto tra l'immagine e il testo
                const Text(
                  'Biblioteca Nazionale',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                // Aggiunto uno spazio vuoto tra il testo e i pulsanti
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: const Color(
                          0xFF6D77FB), // Imposta il colore personalizzato del pulsante come #6D77FB
                    ),
                    child: const Text(
                      'Accedi',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Aggiunto uno spazio vuoto tra i pulsanti
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: const Color(
                          0xFF6D77FB), // Imposta il colore personalizzato del pulsante come #6D77FB
                    ),
                    child: Text(
                      'Registrati',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
