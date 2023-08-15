import 'package:flutter/material.dart';
import 'package:todos/database/notemodel.dart';

import '../database/dbhelper.dart';

class NoteUpdate extends StatefulWidget {

  final NoteModel no;
  const NoteUpdate({super.key, required this.no});

  @override
  State<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {

  TextEditingController titlecnt = TextEditingController();
  TextEditingController descnt = TextEditingController();
  bool switchpos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titlecnt.text = widget.no.title;
    descnt.text = widget.no.desc;
    switchpos = widget.no.isliked.isEven ? false : true ;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).focusColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                maxLines: null,
                controller: titlecnt,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none
                ),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add to Favourites",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Switch(
                          value: switchpos,
                          onChanged: (bool fav) {
                            setState(() {
                              switchpos = fav;
                            });
                          })
                    ],
                  ),
                ),
              TextField(
                controller: descnt,
                selectionControls: MaterialTextSelectionControls(),
                maxLines: null,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: ()=> upNote(),
        child: Icon(Icons.save_outlined , color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
  bool isnull() =>  (titlecnt.text.isEmpty || descnt.text.isEmpty ) ? true : false ;

  void upNote() async {

    int fav = switchpos ? 1 : 0;
    NoteModel no = NoteModel(id: widget.no.id, title: titlecnt.text, desc: descnt.text, date: 'null', col: 000, isliked: fav);
    if(isnull()){
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(const SnackBar(content: Text("Fields must not be empty"),),);
    }else{
      Databasehelper().updateNote(no);
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(const SnackBar(content: Text("updated Successfully")));
    }

  }


}