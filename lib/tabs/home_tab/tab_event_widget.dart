import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  Color backgroundColor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;
  Color? borderColor;

  TabEventWidget(
      {required this.eventName,
      required this.isSelected,
      required this.backgroundColor,
      required this.textSelectedStyle,
      required this.textUnSelectedStyle,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .035, vertical: height * .01),
      decoration: BoxDecoration(
          color: isSelected ? backgroundColor : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor ?? AppColors.white, width: 2)),
      child: Text(
        eventName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}
