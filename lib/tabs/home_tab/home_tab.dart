import 'package:evently_app/tabs/home_tab/event_item_widget.dart';
import 'package:evently_app/tabs/home_tab/tab_event_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> eventNamesList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .09,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text(AppLocalizations.of(context)!.ahmed_fayed,
                    style: AppStyles.bold24White),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.wb_sunny_outlined,
                  size: 30,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  padding: EdgeInsets.all(height * .01),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "En",
                    style: AppStyles.bold14Primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * .03),
            height: height * .14,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                )),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsManager.mapUnSelected,
                    ),
                    SizedBox(
                      width: width * .015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.cairo_egypt,
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventNamesList.length,
                    child: TabBar(
                        onTap: (index) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: height * .02),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        isScrollable: true,
                        tabs: eventNamesList.map((eventName) {
                          return TabEventWidget(
                              eventName: eventName,
                              isSelected: selectedIndex ==
                                  eventNamesList.indexOf(eventName));
                        }).toList())),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .04),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return EventItemWidget();
                },
                itemCount: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
