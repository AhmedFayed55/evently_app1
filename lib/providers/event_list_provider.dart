import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../firebase_utils/firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  int selectedIndex = 0;
  List<String> eventNamesList = [];
  Map<String, String> toEnglishLocalizedMap = {};

  void getEventNameList(BuildContext context) {
    eventNamesList = [
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
    toEnglishLocalizedMap = {
      AppLocalizations.of(context)!.all: "All",
      AppLocalizations.of(context)!.sport: "Sport",
      AppLocalizations.of(context)!.birthday: "Birthday",
      AppLocalizations.of(context)!.meeting: "Meeting",
      AppLocalizations.of(context)!.gaming: "Gaming",
      AppLocalizations.of(context)!.workshop: "Workshop",
      AppLocalizations.of(context)!.book_club: "Book Club",
      AppLocalizations.of(context)!.exhibition: "Exhibition",
      AppLocalizations.of(context)!.holiday: "Holiday",
      AppLocalizations.of(context)!.eating: "Eating",
    };
  }

  List<Event> filterList = [];

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventsList;

    //todo: sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

  void getFilterEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    String? selectedCategory =
        toEnglishLocalizedMap[eventNamesList[selectedIndex] ?? "All"];

    // todo: filtering
    filterList = eventsList.where((event) {
      return event.eventName == selectedCategory;
    }).toList();

    //todo: sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      // All
      getAllEvents();
    } else {
      getFilterEvents();
    }
  }
}
