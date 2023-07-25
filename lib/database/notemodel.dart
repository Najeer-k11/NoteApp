

class NoteModel{
  int id;
  String title;
  String desc;
  String date;
  int col;
  int isliked;

  NoteModel({required this.id,required this.title,required this.desc,required this.date,required this.col,required this.isliked});

  factory NoteModel.fromJson(Map<String,dynamic>obj){
    final id = obj['id'];
    final title = obj['title'];
    final desc = obj['desc'];
    final date = obj['createdat'];
    final col = obj['color'] ?? 1515;
    final isliked = obj['isliked'] ?? 0;

    return NoteModel(title: title, desc: desc,date:date,id: id,col:col,isliked: isliked);
  }
}