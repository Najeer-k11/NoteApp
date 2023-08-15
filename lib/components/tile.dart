import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  final IconData likeicon;
  final String title;
  final String subtitle;
  final String date;
  final Color likeColor;
  final int iconColor;
  final void Function() delete;
  final void Function() like;

  const PageTile(
      {super.key,
      required this.likeicon,
      required this.iconColor,
      required this.likeColor,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.delete,
      required this.like});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 4,
                offset: const Offset(-4, 3),
                blurStyle: BlurStyle.outer)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.data_object_rounded,
            color: Color(iconColor),
            size: 18,
          ),
          const SizedBox(
            width: 5 * 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(date,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: like,
                            child: Icon(
                              likeicon,
                              size: 21,
                              color: likeColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: delete,
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 21,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
