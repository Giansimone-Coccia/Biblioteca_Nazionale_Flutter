import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/DatabaseProvider.dart';
import 'login.dart';
import '../main.dart';

DatabaseProvider databaseProvider = DatabaseProvider();

class Register extends StatelessWidget {
  const Register({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color customPurpleColor = const Color(0xFF6D77FB);

    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded),
        color: customPurpleColor,
        iconSize: 50.0,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
      elevation: 0,
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _registerUser() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        if (isValidEmail(email)) {
          if (isValidPassword(password)) {
            // Chiamata al metodo registerUser su databaseProvider
            databaseProvider.registerUser(email, password);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text('User registered successfully.'),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Invalid Password'),
                  content: Text('Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.'),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid Email'),
                content: Text('Please enter a valid email address.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Mismatch'),
              content: Text('The password and confirm password do not match.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incomplete Form'),
            content: Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.0),
        Text(
          'Hello! Register to get started',
          style: TextStyle(
            color: Colors.black,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100.0),
        CustomTextField(
          controller: _emailController,
          hintText: 'Email',
          obscureText: false,
        ),
        SizedBox(height: 20.0),
        CustomTextField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 20.0),
        CustomTextField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          obscureText: true,
        ),
        SizedBox(height: 22.0),
        RegisterButton(
          onPressed: _registerUser,
        ),
        SizedBox(height: 8.0),
        LoginLink(),
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);
  final VoidCallback onPressed;

  RegisterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: customPurpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(double.infinity, 60.0),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Already registered? ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
        children: [
          TextSpan(
            text: 'Login now',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14.0,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color customContainerColor = const Color(0xFFECEAEA);
    final Color customPurpleColor = const Color(0xFF6D77FB);

    return Container(
      decoration: BoxDecoration(
        color: customContainerColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: customPurpleColor, width: 2.0), // Aggiungi questa linea per il bordo viola
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: customPurpleColor), // Aggiungi questa linea per il testo del placeholder viola
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.black), // Aggiungi questa linea per il testo della casella di testo nero
        obscureText: obscureText,
      ),
    );
  }
}


