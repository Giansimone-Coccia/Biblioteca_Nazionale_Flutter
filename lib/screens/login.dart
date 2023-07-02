import 'package:flutter/material.dart';
import 'homepage.dart';
import '../widgets/bookList.dart';
import 'register.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: CustomAppBarLogin(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: LoginCard(),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarLogin extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color customPurpleColor = const Color(0xFF6D77FB);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}


class LoginCard extends StatelessWidget {
  const LoginCard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
            LoginTitle(),
            const SizedBox(height: 40.0),
            InputField(
              hintText: 'Email',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 20.0),
            InputField(
              hintText: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 30.0),
            LoginButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            SizedBox(height: 12.0),
            const SizedBox(height: 12.0),
            const LoginText(
              text: 'Login with',
              fontSize: 14.0,
              color: Colors.grey,
            ),
            SizedBox(height: 4.0),
            Image.asset(
              'assets/images/google_icon.png',
              width: 100.0,
              height: 50.0,
            ),
            SizedBox(height: 4.0),
            LoginText(
              text: 'Not yet registered? ',
              fontSize: 14.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: LoginText(
                text: 'Register now',
                fontSize: 14.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}

// Rimani invariato
class LoginTitle extends StatelessWidget {
  const LoginTitle({Key? key});

  @override
  Widget build(BuildContext context) {
    const Color customPurpleColor = Color(0xFF6D77FB);

    return const Text(
      'Login',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: customPurpleColor,
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Rimani invariato
class InputField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;

  const InputField({
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color customPurpleColor = const Color(0xFF6D77FB);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: customPurpleColor,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: customPurpleColor,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: customPurpleColor,
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }
}

// Rimani invariato
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color customPurpleColor = const Color(0xFF6D77FB);

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'Login',
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

// Rimani invariato
class LoginText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const LoginText({
    required this.text,
    required this.fontSize,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
