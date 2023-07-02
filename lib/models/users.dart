import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'DatabaseProvider.dart';


class Users {
  final int id;
  final String email;
  final String password;
  bool isLogged;

  Users({
    required this.id,
    required this.email,
    required this.password,
    this.isLogged = false,
  });

  //ESEMPIO DI UTILIZZO
  /*Users user = await Users.getUserByEmail('example@example.com');
if (user != null) {
  await user.login();
  // Utente autenticato con successo
}

// ... Alcune operazioni ...

await user.logout();
// Utente disconnesso
*/

  String getEmailCurrentUser() {
    return this.email;
  }

  Future<void> save() async {
    final Database db = await DatabaseProvider.createDatabase();
    await db.insert(
      'users',
      {
        'id': id,
        'email': email,
        'password': password,
        'isLogged': isLogged ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Users?> getUserByEmail(String email) async {
    final Database db = await DatabaseProvider.createDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Users(
        id: maps[0]['id'],
        email: maps[0]['email'],
        password: maps[0]['password'],
        isLogged: maps[0]['isLogged'] == 1,
      );
    }

    return null;
  }

  Future<void> login() async {
    final Database db = await DatabaseProvider.createDatabase();
    await db.update(
      'users',
      {'isLogged': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    isLogged = true;
  }

  Future<void> logout() async {
    final Database db = await DatabaseProvider.createDatabase();
    await db.update(
      'users',
      {'isLogged': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    isLogged = false;
  }
}
