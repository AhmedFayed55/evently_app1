import 'package:evently_app/tabs/home_tab/add_event/add_event_screen.dart';
import 'package:evently_app/tabs/home_tab/home_tab.dart';
import 'package:evently_app/tabs/love_tab/love_tab.dart';
import 'package:evently_app/tabs/map_tab/map_tab.dart';
import 'package:evently_app/tabs/profile_tab/profile.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_tab";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavItem(
                    index: 0,
                    selectedIconName: AssetsManager.homeSelected,
                    iconName: AssetsManager.homeUnSelected,
                    lable: AppLocalizations.of(context)!.home),
                buildBottomNavItem(
                    index: 1,
                    selectedIconName: AssetsManager.mapSelected,
                    iconName: AssetsManager.mapUnSelected,
                    lable: AppLocalizations.of(context)!.map),
                buildBottomNavItem(
                    index: 2,
                    selectedIconName: AssetsManager.loveSelected,
                    iconName: AssetsManager.loveUnSelected,
                    lable: AppLocalizations.of(context)!.love),
                buildBottomNavItem(
                    index: 3,
                    selectedIconName: AssetsManager.profileSelected,
                    iconName: AssetsManager.profileUnSelected,
                    lable: AppLocalizations.of(context)!.profile),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(
          Icons.add,
          size: 28,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItem(
      {required int index,
      required String selectedIconName,
      required String lable,
      required String iconName}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? selectedIconName : iconName)),
        label: lable);
  }
}
