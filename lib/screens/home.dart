import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos/components/tile.dart';
import 'package:todos/database/dbhelper.dart';
import 'package:todos/database/notemodel.dart';
import 'package:todos/screens/noteMaker.dart';
import 'package:todos/screens/noteupdater.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = true;
  int currentid = 0;
  List<String> li = ['All Notes', 'favorites', 'todos'];
  List<List<NoteModel>> notes = [[], [], []];

  @override
  void initState() {
    if (isloading) {
      initNotes();
    }
    // TODO: implement initState
    super.initState();
  }

  initNotes() async {
    var dummy = await Databasehelper().fetchall();
    var dum = await Databasehelper().favNotes();
    setState(() {
      notes[0] = dummy.reversed.toList();
      notes[1] = dum.reversed.toList();
      isloading = false;
    });
  }

  void noteLike(int id, int liked) async {
    int like = liked == 1 ? 0 : 1;
    Databasehelper().likeUpdate(id, like);
    initNotes();
  }

  void dtnote(int id) async {
    Databasehelper().Delete(id);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      const SnackBar(
        content: Text('Deleted Successfully'),
      ),
    );
    initNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            "To Notes",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Theme.of(context).brightness),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              onPressed: () {
                initNotes();
              },
              icon: const Icon(Icons.refresh_rounded),
              color: Theme.of(context).focusColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
              ),
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: li.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, id) => InkWell(
                  onTap: () {
                    setState(() {
                      currentid = id;
                    });
                  },
                  child: Container(
                    width: li[id].length * 10.13,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border(
                        top: BorderSide(
                            color: currentid == id
                                ? Theme.of(context).focusColor
                                : Theme.of(context).disabledColor),
                        left: BorderSide(
                            color: currentid == id
                                ? Theme.of(context).focusColor
                                : Theme.of(context).disabledColor),
                        bottom: BorderSide(
                            color: currentid == id
                                ? Theme.of(context).focusColor
                                : Theme.of(context).disabledColor),
                        right: BorderSide(
                            color: currentid == id
                                ? Theme.of(context).focusColor
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        li[id],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: currentid == id
                                ? Theme.of(context).focusColor
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            notes[currentid].isEmpty
                ? Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'You dont have any ${li[currentid]}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: notes[currentid].length,
                        itemBuilder: (context, id) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NoteUpdate(no: notes[currentid][id]),
                              ),
                            );
                          },
                          child: PageTile(
                            likeicon: notes[currentid][id].isliked == 0
                                ? Icons.favorite_border_rounded
                                : Icons.favorite_rounded,
                            iconColor: notes[currentid][id].col,
                            likeColor: notes[currentid][id].isliked == 1
                                ? Colors.pink
                                : Theme.of(context).focusColor,
                            title: notes[currentid][id].title,
                            subtitle: notes[currentid][id].desc,
                            date: notes[currentid][id].date,
                            delete: () => dtnote(notes[currentid][id].id),
                            like: () => noteLike(notes[currentid][id].id,
                                notes[currentid][id].isliked),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteMaker(),
            ),
          );
        },
        child: Icon(
          Icons.add_circle_outline_rounded,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
