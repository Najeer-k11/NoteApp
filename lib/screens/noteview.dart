import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/database/fncs.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:todos/themes/themes.dart';

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

  bool isimp = false;
  


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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('saved successfully'),),);
              }
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
              margin:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: TextField(
                controller: titlecnt,
                decoration: InputDecoration(
                  hintText: 'Title',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: Theme.of(context).textTheme.bodyMedium
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              margin:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Important"),
                  Switch(
                  activeColor: secondarycolor,
                  value: isimp,
                  activeTrackColor: Theme.of(context).primaryColor,
                  onChanged: (bool imp){
                    setState(() {
                      isimp = imp;
                    });
                  })
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.2)
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: TextField(
                controller: descnt,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'description',
                  enabledBorder: InputBorder.none,
                  hintStyle:Theme.of(context).textTheme.bodyMedium,
                  focusedBorder: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white),
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
