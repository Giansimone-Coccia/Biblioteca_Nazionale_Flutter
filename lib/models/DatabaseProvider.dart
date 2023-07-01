import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static Future<Database> createDatabase() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            email TEXT,
            password TEXT,
            isLogged INTEGER
          )
        ''');
      },
    );
  }
}
