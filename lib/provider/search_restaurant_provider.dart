import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/search_restaurant.dart';
import 'package:flutter_restaurant/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  SearchRestaurantProvider({required this.apiService, required this.query}) {
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
      final response = await apiService.searchRestaurant(query);

      if(!response.error){
        if(response.founded == 0){
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Restaurant Found';
        }else{
          _state = ResultState.hasData;
          notifyListeners();
          return _fetchResult = response.restaurants;
        }
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = "Failed to search restaurant";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}