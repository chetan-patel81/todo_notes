import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/utils/style_utils.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_string.dart';
import '../../../utils/media_query_utils.dart';

class HomeCard extends StatefulWidget {
  final String title;
  final String image;
  final void Function()? onTap;


  const HomeCard(
      {Key? key, required this.title, required this.image, this.onTap, })
      : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    print("build");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hovered) {
          setState(() {
            isHovered = hovered;
          });
        },
        child: Container(
          height: screenHeight / 3,
          width: screenWidth / 2,
          decoration: BoxDecoration(
            color: isHovered ? AppColor.secondaryColor : AppColor.darkColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Flexible(
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                widget.title,
                style: MyAppStyle.titleStyle(AppColor.lightColor),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
