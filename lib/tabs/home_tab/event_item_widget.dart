import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        top: height * .02,
      ),
      height: height * .28,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AssetsManager.birthday,
              )),
          border: Border.all(color: AppColors.primaryLight, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .01),
              padding: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white),
              child: Column(
                children: [
                  Text("22", style: AppStyles.bold20Primary),
                  Text(
                    "Nov",
                    style: AppStyles.bold20Primary,
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            padding: EdgeInsets.symmetric(
                horizontal: width * .03, vertical: height * .009),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "This is a Birthday Party",
                  style: AppStyles.bold14Black,
                ),
                Icon(Icons.favorite_border)
              ],
            ),
          )
        ],
      ),
    );
  }
}
