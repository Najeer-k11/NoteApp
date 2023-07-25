

import 'package:flutter_svg/flutter_svg.dart';
import 'package:todos/database/fncs.dart';
import 'package:todos/database/notemodel.dart';
import 'package:todos/screens/noteview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int idx = 0;
  List<NoteModel> notes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notefetch();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    notefetch();
  }

  void notefetch() async {
    var data = await Functions().fetchnotes();
    setState(() {
      notes = data;
    });
  }

  void upnote(int id,int isliked) async{
    await Functions().likeid(id, isliked);
    notefetch();
  }

  void dtnote(int id) async {
    await Functions().deleteItem(id);
    notefetch();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title : Text(
          "ToNotes",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          notefetch();
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemCount: notes.isNotEmpty ? notes.length : 1,
          itemBuilder: (context, i) => notes.isEmpty? Container(
            height: he/2,
            child: Center(
              child: Text('You dont have any notes',style: Theme.of(context).textTheme.bodyMedium,),
            ),
          ):
          Container(
                height: he /6,
                width: wi,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    gradient: RadialGradient(
                      colors: [
                      Color(notes[i].col).withAlpha(200),
                      Theme.of(context).cardColor,
                    ],
                    radius: 1,tileMode: TileMode.clamp,
                    center: Alignment.topLeft
                    ),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 4),
                padding: EdgeInsets.all(18),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notes[i].title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Expanded(
                          child: Text(
                        notes[i].desc,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.clip,
                      )),
                      Text(
                        notes[i].date,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  Column(children: [
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [ 
                        InkWell(
                          onTap: (){
                            int val = notes[i].isliked == 1 ? 0 : 1 ;
                            upnote(notes[i].id, val);
                          },

                          child: Container(
                              height: 30,
                              child: SvgPicture.asset(
                                notes[i].isliked == 1 ?'assets/favf.svg':'assets/favo.svg',
                                height: 24,
                                color: notes[i].isliked == 1 ?Colors.red: Theme.of(context).iconTheme.color,
                              ),
                          ),
                        ),
                        SizedBox(width: wi*0.05,),
                        InkWell(
                            onTap: (){
                              dtnote(notes[i].id);
                            },
                            child: Container(
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/delete.svg',
                                height: 24,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ]),
                ]),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Noteeditor(),
            ),
          );
        },
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.4),
        child: SvgPicture.asset(
          'assets/note.svg',
          height: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
