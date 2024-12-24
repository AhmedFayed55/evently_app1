import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;

  TabEventWidget({required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .035, vertical: height * .008),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white, width: 2)),
      child: Text(
        eventName,
        style: isSelected ? AppStyles.medium16Primary : AppStyles.medium16White,
      ),
    );
  }
}
