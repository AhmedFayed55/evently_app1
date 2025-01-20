import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Event> favoriteEvents = [];

  void updateFavorites(List<Event> allEvents) {
    favoriteEvents = allEvents.where((event) => event.isFavorite).toList();
    notifyListeners();
  }
}
