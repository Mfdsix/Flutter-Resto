import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/search_restaurant.dart';
import 'package:flutter_restaurant/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({Key? key, required this.apiService});

  List<Restaurant> _fetchResult = [];
  ResultState _state = ResultState.standBy;
  String _message = '';

  String get message => _message;

  List<Restaurant> get result => _fetchResult;

  ResultState get state => _state;

  Future<dynamic> fetchData(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.searchRestaurant(query);

      if (!response.error) {
        if (response.founded == 0) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Restaurant Found';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _fetchResult = response.restaurants;
        }
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = "Failed to search restaurant";
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Please Check your Internet Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Failed to Fetch Data";
    }
  }
}
