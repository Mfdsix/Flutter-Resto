import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/detail_restaurant.dart';
import 'package:flutter_restaurant/utils/result_state.dart';

class GetRestaurantByIdProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  GetRestaurantByIdProvider({required this.apiService, required this.restaurantId}) {
    _fetchData();
  }

  late Restaurant _fetchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Restaurant get result => _fetchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurantById(restaurantId);

      if(!response.error){
        _state = ResultState.hasData;
        notifyListeners();
        return _fetchResult = response.restaurant;
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = response.message;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}