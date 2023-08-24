import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/list_restaurant.dart';
import 'package:flutter_restaurant/provider/api/get_all_restaurant_provider.dart';
import 'package:flutter_restaurant/ui/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'restaurant_list_test.mocks.dart';

@GenerateMocks([ApiService])
void main(){
  group('Restaurant List Widget Test', () {
    testWidgets('ListView should be exists', (WidgetTester widgetTester) async {
      final apiService = MockApiService();

      when(apiService.getAllRestaurants().then((value) async {
        final jsonResponse = await File('get_all_restaurant_response.json').readAsString();
        return ListRestaurantResponse.fromJson(json.decode(jsonResponse));
      }));

      await widgetTester.pumpWidget(
        Provider.value(
          value: GetAllRestaurantProvider(apiService: apiService),
          child: const HomePage(),
        )
      );
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}