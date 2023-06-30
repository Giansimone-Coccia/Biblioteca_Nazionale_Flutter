import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    // Definisci il nuovo colore
    final Color customPurpleColor = Color(0xFF6D77FB);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6D77FB), // Utilizza il nuovo colore
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: customPurpleColor, // Utilizza il nuovo colore
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: customPurpleColor, // Utilizza il nuovo colore
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: customPurpleColor, // Utilizza il nuovo colore
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: customPurpleColor, // Utilizza il nuovo colore
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: customPurpleColor, // Utilizza il nuovo colore
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: customPurpleColor, // Utilizza il nuovo colore
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: customPurpleColor, // Utilizza il nuovo colore
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 60.0),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    const Text(
                      'Login with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                    Image.asset(
                      'assets/images/google_icon.png',
                      width: 100.0,
                      height: 50.0,
                    ),
                    SizedBox(height: 8.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not yet registered? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
