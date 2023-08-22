import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/preferences/notification_preference.dart';

class NotificationPreferenceProvider extends ChangeNotifier {
  NotificationPreference notificationPreference;

  NotificationPreferenceProvider({required this.notificationPreference}) {
    _getDailyRecommendationPreference();
  }

  bool _isDailyRecommendationActive = false;
  bool get isDailyRecommendationActive => _isDailyRecommendationActive;

  void _getDailyRecommendationPreference() async {
    _isDailyRecommendationActive =
        await notificationPreference.isDailyRecommendationActive;
    notifyListeners();
  }

  void toggleDailyRecommendationPreference(bool value) {
    notificationPreference.setDailyRecommendation(value);
    _getDailyRecommendationPreference();
  }
}
