import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/tabs/home_tab/event_item_widget.dart';
import 'package:evently_app/tabs/home_tab/tab_event_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents();
    }
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
                IconButton(
                    onPressed: () {
                      if (themeProvider.appTheme == ThemeMode.light) {
                        themeProvider.changeTheme(ThemeMode.dark);
                      } else {
                        themeProvider.changeTheme(ThemeMode.light);
                      }
                    },
                    icon: themeProvider.appTheme == ThemeMode.light
                        ? Icon(
                            Icons.nightlight_round,
                            color: AppColors.black,
                          )
                        : Icon(
                            Icons.wb_sunny_outlined,
                            color: AppColors.white,
                          )),
                SizedBox(
                  width: width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    if (languageProvider.appLanguage == "en") {
                      languageProvider.changeLanguage("ar");
                    } else {
                      languageProvider.changeLanguage("en");
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(height * .01),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: languageProvider.appLanguage == "en"
                          ? Text(
                              "En",
                              style: AppStyles.bold14Primary,
                            )
                          : Text(
                              "AR",
                              style: AppStyles.bold14Black,
                            )),
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
                    length: eventListProvider.eventNamesList.length,
                    child: TabBar(
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(index);
                        },
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: height * .02),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        isScrollable: true,
                        tabs: eventListProvider.eventNamesList.map((eventName) {
                          return TabEventWidget(
                              textSelectedStyle: AppStyles.medium16Primary,
                              textUnSelectedStyle: AppStyles.medium16White,
                              backgroundColor: AppColors.white,
                              eventName: eventName,
                              isSelected: eventListProvider.selectedIndex ==
                                  eventListProvider.eventNamesList
                                      .indexOf(eventName));
                        }).toList())),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .04),
              child: eventListProvider.filterList.isEmpty
                  ? Center(
                      child: Text("No Events yet"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          event: eventListProvider.filterList[index],
                        );
                      },
                      itemCount: eventListProvider.filterList.length,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
