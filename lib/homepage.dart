import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/welcome_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 125,
                height: 125,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/round_menu_book_48.png',
                      width: 65,
                      height: 65,
                      fit: BoxFit.contain,
                      semanticLabel: 'Notifications Image',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'App Name',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login'),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
