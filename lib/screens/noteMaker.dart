import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todos/database/dbhelper.dart';

class NoteMaker extends StatefulWidget {
  const NoteMaker({super.key});

  @override
  State<NoteMaker> createState() => _NoteMakerState();
}

class _NoteMakerState extends State<NoteMaker> {
  int colindex = 0;

  int colvalue = Colors.blue.value;
  List<Color> cols = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.yellow
  ];
  bool switchpos = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        foregroundColor: Theme.of(context).focusColor,
        backgroundColor: Colors.transparent,
        title: Text(
          "Note Editor ",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Theme.of(context).brightness),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextField(
                  controller: titleController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Title goes Here',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    fillColor: null,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cols.length,
                    (ix) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            colindex = ix;
                            colvalue = cols[colindex].value;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: colindex == ix
                                      ? Theme.of(context).focusColor
                                      : Colors.transparent),
                              shape: BoxShape.circle,
                              color: cols[ix]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextField(
                  controller: descController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Description goes Here',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    fillColor: null,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          savenote(titleController.text, descController.text, colvalue);
        },
        label: Icon(
          Icons.save_alt_rounded,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        backgroundColor: Theme.of(context).focusColor,
      ),
    );
  }

  bool isnull() => (titleController.text.isEmpty || descController.text.isEmpty)
      ? true
      : false;

  void savenote(String txt, String desc, int col) async {
    String dtnow = DateFormat('EEE , dd/mm/yyyy').format(DateTime.now());
    int fav = switchpos ? 1 : 0;
    if (isnull()) {
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(
        const SnackBar(
          content: Text("Fields must not be empty"),
        ),
      );
    } else {
      Databasehelper().Insert(txt, desc, dtnow, col, fav);
      ScaffoldMessenger.maybeOf(context)!
          .showSnackBar(const SnackBar(content: Text("Saved Successfully")));
    }
  }
}
