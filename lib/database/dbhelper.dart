
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todos/database/notemodel.dart';
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

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<String> get fullpath async {
    const name = 'tonotes.db';
    var paths = await getDatabasesPath();
    return join(paths, name);
  }

  Future<Database> initDB() async {
    final path = await fullpath;
    var database = await openDatabase(path, onCreate: (db, version) async {
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
    }, singleInstance: true, version: 1);
    return database as Database;
  }

  Future<List<NoteModel>> fetchall() async {
    Database db = await Databasehelper().database;
    var notes = await db.rawQuery('SELECT * FROM tonotes ');
    return notes.map((e) => NoteModel.fromJson(e)).toList();
  }

  void Insert(String title , String desc , String date , int colvalue , int fav) async {
    Database db = await Databasehelper().database;
    await db.rawInsert(
        '''INSERT INTO tonotes(title,desc,createdat,color,isliked) VALUES(?,?,?,?,?)''',
        [
          title,
          desc,
          date,
          colvalue,
          fav
        ]);
  }

  void Delete(int id) async {
    Database db = await Databasehelper().database;
    await db.rawDelete('''
DELETE FROM tonotes WHERE id = ? 
''', [id]);
  }

  void likeUpdate(int id, int isLiked) async {
    Database db = await Databasehelper().database;
    await db.rawUpdate('UPDATE tonotes SET isliked = ? WHERE id = ?',[isLiked , id]);
  }

  void updateNote(NoteModel no) async {
    Database db = await Databasehelper().database;
    await db.rawUpdate('UPDATE tonotes SET title = ? , desc = ? , isliked = ? WHERE id = ? ',[
      no.title , no.desc ,no.isliked , no.id
    ]);
  }

  Future<List<NoteModel>> favNotes() async {
    Database db = await Databasehelper().database;
    var notes = await db.rawQuery(
      'SELECT * FROM tonotes WHERE isliked = ? ' ,[1]
    );
    return notes.map((e) => NoteModel.fromJson(e)).toList();
  }
}
