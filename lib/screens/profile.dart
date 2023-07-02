import 'package:flutter/material.dart';

final Color customPurpleColor = const Color(0xFF6D77FB);

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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
              child: buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: customPurpleColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // Logica per il logout
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
              SizedBox(height: 8),
              Text(
                "You cannot change your Google\ncredentials, contact your provider",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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

  Widget buildForm() {
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor, // Colore rosso
              ),
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor, // Colore rosso
              ),
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: customPurpleColor, // Colore rosso
              ),
            ),
            hintText: "Confirm password",
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Logica per l'aggiornamento del profilo
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
              // Logica per l'eliminazione del profilo
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
}
