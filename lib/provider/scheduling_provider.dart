import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utils/background_service.dart';
import 'package:flutter_restaurant/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isDailyRecommendationScheduled = false;
  bool get isDailyRecommendationScheduled => _isDailyRecommendationScheduled;

  Future<bool> scheduleDailyRecommendation(bool value) async {
    const alarmId = 333;
    _isDailyRecommendationScheduled = value;

    if (isDailyRecommendationScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), alarmId, BackgroundService.callback,
          startAt: DateTimeHelper.getWithTimeSpecific('11:00:00'),
          exact: true,
          wakeup: true);
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(alarmId);
    }
  }
}
