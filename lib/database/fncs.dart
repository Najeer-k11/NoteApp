
import 'package:todos/database/notemodel.dart';

import 'dbhelper.dart';
import 'package:sqflite/sqflite.dart';

class Functions{
  
Future<void> insertDb(String title,String desc,String date,int col,int val) async{

  Database db = await Databasehelper().database;

  await db.rawInsert('''INSERT INTO tonotes(title,desc,createdat,color,isliked) VALUES (?,?,?,?,?)''',[title,desc,date,col,val]);

}

Future<List<NoteModel>> fetchnotes() async{
  Database db = await Databasehelper().database;

  var notes = await db.rawQuery('''SELECT * FROM tonotes ORDER BY id DESC''');

  return notes.map((e) => NoteModel.fromJson(e)).toList();
  
}

Future<void> likeid(int ind,int isliked) async{
  Database db = await Databasehelper().database;

  await db.rawUpdate('''UPDATE tonotes SET isliked = ? WHERE id = ?''', [isliked,ind]);
}

Future<void> deleteItem(int idx) async{
  Database db = await Databasehelper().database;

  await db.rawDelete('''DELETE FROM tonotes WHERE id = ?''',[idx]);
}
}