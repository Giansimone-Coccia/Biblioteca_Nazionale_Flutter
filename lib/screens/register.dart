import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import '../main.dart';

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
class RegisterForm extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);
  final Color customContainerColor = const Color(0xFFECEAEA);

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
          hintText: 'Email',
          obscureText: true,
        ),
        SizedBox(height: 20.0),
        CustomTextField(
          hintText: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 20.0),
        CustomTextField(
          hintText: 'Confirm Password',
          obscureText: true,
        ),
        SizedBox(height: 22.0),
        RegisterButton(),
        SizedBox(height: 8.0),
        LoginLink(),
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  final Color customPurpleColor = const Color(0xFF6D77FB);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()), // Sostituisci `BookList` con la schermata a cui vuoi navigare dopo la registrazione
        );
      },
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
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color customContainerColor = const Color(0xFFECEAEA);

    return Container(
      decoration: BoxDecoration(
        color: customContainerColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }
}

