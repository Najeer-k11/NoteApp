
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'dbhelper.dart';


class Databasehelper {
  Database? _database;
  String tablename = 'tonotes';
  String col1 = 'id';
  String col2 = 'title';
  String col3 = 'desc';
  String col4 = 'createdat';
  String col5 = 'color';
  String col6 = 'isliked';

  Future<Database> get database async{

    
    if(_database  != null){
      return _database!;
    }
    _database = await initDB();
    return _database!;

  }


  Future<String> get fullpath async{
    const name = 'tonotes.db';
    var paths = await getDatabasesPath();
    return join(paths,name);
  }

  Future<Database> initDB() async{
    final path = await fullpath;
    var database = await openDatabase(path,onCreate:  (db, version) async{
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tablename(
          $col1 INTEGER PRIMARY KEY AUTOINCREMENT,
          $col2 TEXT NOT NULL,
          $col3 TEXT NOT NULL,
          $col4 TEXT NOT NULL,
          $col5 INTEGER NOT NULL,
          $col6 INTEGER NOT NULL
        )
      ''');
    },singleInstance: true,version: 1);
    return database as Database;
  }
}



