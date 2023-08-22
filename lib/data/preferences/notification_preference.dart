import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreference {
  final Future<SharedPreferences> sharedPreferences;

  NotificationPreference({required this.sharedPreferences});

  static const dailyRecommendation = 'NOTIFICATION_DAILY_RECOMMENDATION';

  Future<bool> get isDailyRecommendationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRecommendation) ?? false;
  }

  void setDailyRecommendation(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRecommendation, value);
  }
}
