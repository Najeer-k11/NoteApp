import 'package:flutter/material.dart';
import 'package:todos/database/fncs.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';

class Noteeditor extends StatefulWidget {

 const Noteeditor({super.key });

  @override
  State<Noteeditor> createState() => _NoteeditorState();
}

class _NoteeditorState extends State<Noteeditor> {
  int idx = 0;

  List<MaterialColor> color = [Colors.blue, Colors.green, Colors.yellow];

  TextEditingController titlecnt = TextEditingController();
  TextEditingController descnt = TextEditingController();

  


  Future<void> noteInsert(String title, String desc) async {
    String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    await Functions().insertDb(title, desc, date, color[idx].value,0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Theme.of(context).iconTheme.color,
            size: 24,
          ),
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
            ),
            elevation: 0,
            initialValue: idx,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              height: 30,
              width: 30,
              decoration:
                  BoxDecoration(color: color[idx], shape: BoxShape.circle),
            ),
            itemBuilder: (BuildContext) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration:
                          BoxDecoration(color: color[0], shape: BoxShape.circle),
                    ),

                    SizedBox(width: 10,),
                    Text('Blue',style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                onTap: () {
                  setState(() {
                    idx = 0;
                  });
                },
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration:
                          BoxDecoration(color: color[1], shape: BoxShape.circle),
                    ),

                    SizedBox(width: 10,),
                    Text('Green',style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                onTap: () {
                  setState(() {
                    idx = 1;
                  });
                },
              ),
              PopupMenuItem(
                value: 2,
                
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration:
                          BoxDecoration(color: color[2], shape: BoxShape.circle),
                    ),

                    SizedBox(width: 10,),
                    Text('Yellow',style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                onTap: () {
                  setState(() {
                    idx = 2;
                  });
                },
              )
            ],
          ),
          InkWell(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: SvgPicture.asset(
                'assets/save.svg',
                color: Theme.of(context).iconTheme.color,
                height: 30,
              ),
            ),
            onTap: () async {
              if (titlecnt.text.isEmpty || descnt.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fields must be non empty to save'),
                  ),
                );
              } else {
                await noteInsert(titlecnt.text, descnt.text);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).highlightColor
              ),
              child: TextField(
                controller: titlecnt,
                decoration: InputDecoration(
                  hintText: 'Title',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  hintStyle: Theme.of(context).textTheme.titleMedium
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).highlightColor
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: descnt,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'description',
                  enabledBorder: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  focusedBorder: InputBorder.none,
                  labelStyle: Theme.of(context).textTheme.bodyMedium
                ),
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ],
        ),
      ),
    );
  }
}
