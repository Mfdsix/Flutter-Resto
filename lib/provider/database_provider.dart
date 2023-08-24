import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/db/database_helper.dart';
import 'package:flutter_restaurant/data/model/detail_restaurant.dart';
import 'package:flutter_restaurant/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper});

  ResultState _state = ResultState.standBy;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _result = [];
  List<Restaurant> get result => _result;

  void getFavoriteRestaurants() async {
    _state = ResultState.loading;
    _result = await databaseHelper.getFavoriteRestaurants();
    if (_result.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'No Favorited Restaurant';
    }

    notifyListeners();
  }

  void addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavoriteRestaurant(restaurant);
      getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to Add Favorite Restaurant';
      notifyListeners();
    }
  }

  Future<bool> isFavoriteRestaurant(String restaurantId) async {
    final restaurant =
        await databaseHelper.getFavoriteRestaurantById(restaurantId);
    return restaurant.isNotEmpty;
  }

  void removeFavoriteRestaurant(String restaurantId) async {
    try {
      await databaseHelper.removeFavoriteRestaurantById(restaurantId);
      getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to Remove Favorite Restaurant';
      notifyListeners();
    }
  }
}
