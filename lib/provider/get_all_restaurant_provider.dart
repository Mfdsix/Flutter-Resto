import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/list_restaurant.dart';
import 'package:flutter_restaurant/utils/result_state.dart';

class GetAllRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  GetAllRestaurantProvider({required this.apiService}) {
    _fetchData();
  }

  late List<Restaurant> _fetchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant> get result => _fetchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getAllRestaurants();

      if (!response.error) {
        if (response.count == 0) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Restaurant Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _fetchResult = response.restaurants;
        }
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = response.message;
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
