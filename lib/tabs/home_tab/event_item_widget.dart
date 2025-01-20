import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  Event event;
  Function onIconPressed;

  EventItemWidget({required this.event, required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool isFavorite = false;
    String monthName = DateFormat.MMM()
        .format(event.dateTime); //todo: convert month number to month name
    return Container(
      margin: EdgeInsets.only(
        top: height * .02,
      ),
      height: height * .28,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                event.image,
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
                  Text("${event.dateTime.day}", style: AppStyles.bold20Primary),
                  Text(
                    "${monthName}",
                    style: AppStyles.bold20Primary,
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            padding: EdgeInsets.symmetric(
                horizontal: width * .03, vertical: height * .002),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: AppStyles.bold14Black,
                ),
                IconButton(
                  onPressed: () {
                    onIconPressed();
                  },
                  icon: Icon(
                    event.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: event.isFavorite
                        ? AppColors.primaryLight
                        : AppColors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
