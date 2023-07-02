import 'package:flutter/material.dart';

import '../models/DatabaseProvider.dart';
import '../models/auth_manager.dart';

final Color customPurpleColor = const Color(0xFF6D77FB);

DatabaseProvider databaseProvider = DatabaseProvider();

class Profile extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: customPurpleColor,
              child: buildHeader(),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: buildForm(context),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: customPurpleColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Logout'),
                      onPressed: () {
                        // Logica per il logout
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5),
        Text(
          "Email",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Modify your profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Enter email",
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: passwordController,
          obscureText: true, // Mostra solo puntini
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Enter password",
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Confirm New Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: confirmPasswordController,
          obscureText: true, // Mostra solo puntini
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Confirm password",
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              updateProfile(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: customPurpleColor,
            ),
            child: Text(
              "Update",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Profile'),
                    content: Text('Are you sure you want to delete your profile?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          // Logica per l'eliminazione del profilo
                          Navigator.of(context).pop();
                          performDeleteProfile(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: customPurpleColor,
            ),
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }


  void performDeleteProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('This action cannot be undone. Are you sure you want to delete your profile?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                // Esegui l'azione di eliminazione del profilo
                deleteProfile(context);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteProfile(BuildContext context) {
    final int? currentUserId = AuthManager().currentUserId;
    if (currentUserId != null) {
      databaseProvider.removeUser(currentUserId);
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User ID not found.'),
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

  void updateProfile(BuildContext context) {
    final int? currentUserId = AuthManager().currentUserId;
    if (currentUserId != null) {
      String newEmail = emailController.text.trim();
      String newPassword = passwordController.text.trim();
      String confirmedPassword = confirmPasswordController.text.trim();

      if (newPassword.isNotEmpty && newPassword != confirmedPassword) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Passwords do not match.'),
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
        return;
      }

      if (newEmail.isNotEmpty) {
        databaseProvider.updateUserEmail(currentUserId, newEmail);
      }

      if (newPassword.isNotEmpty) {
        databaseProvider.updateUserPassword(currentUserId, newPassword);
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Profile updated successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  emailController.clear();
                  passwordController.clear();
                  confirmPasswordController.clear();
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
            title: Text('Error'),
            content: Text('User ID not found.'),
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
}
