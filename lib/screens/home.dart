import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:todos/database/fncs.dart';
import 'package:todos/database/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos/themes/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int idx = 0;
  List<NoteModel> notes = [];

  List<String> tk = ['All notes', 'Favourites', 'Important'];

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

  void upnote(int id, int isliked) async {
    await Functions().likeid(id, isliked);
    notefetch();
  }

  void dtnote(int id) async {
    await Functions().deleteItem(id);
    notefetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: scaffoldbg,
          centerTitle: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          title: const Text(
            'ToNotes',
            style: TextStyle(color: Colors.white),
          )),
      backgroundColor: scaffoldbg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 2.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, id) => InkWell(
                  onTap: () {
                    setState(() {
                      idx = id;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    margin: EdgeInsets.only(right: 6.w),
                    decoration: BoxDecoration(
                        color: idx == id
                            ? secondarycolor
                            : secondarycolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),),
                        /// border: idx == id
                        ///     ? const Border(
                        ///         top: BorderSide(color: Colors.white, width: 1),
                        ///         bottom:
                        ///             BorderSide(color: Colors.white, width: 3),
                        ///         left: BorderSide(color: Colors.white, width: 3),
                        ///         right:
                        ///             BorderSide(color: Colors.white, width: 1))
                        ///     : const Border(
                        ///         top: BorderSide.none,
                        ///         bottom: BorderSide.none,
                        ///         left: BorderSide.none,
                        ///         right: BorderSide.none)),
                    child: Center(
                      child: Text(
                        tk[id],
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: idx == id ? Colors.white : Colors.white38),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: notes.length,
                itemBuilder: (context, id) => InkWell(
                  onLongPress: (){
                    dtnote(notes[id].id);
                  },
                  child: Container(
                    height: 65.h,
                    width: 290.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(notes[id].title,style: TextStyle(
                      color: textdark.withOpacity(0.8),
                      fontSize: 13.sp
                    ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondarycolor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
