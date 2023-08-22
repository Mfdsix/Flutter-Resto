import 'dart:io';

import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/provider/notification_preference_provider.dart';
import 'package:flutter_restaurant/provider/scheduling_provider.dart';
import 'package:flutter_restaurant/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const Settings({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          settingsTitle,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Daily Recommendation'),
            trailing:
                Consumer2<NotificationPreferenceProvider, SchedulingProvider>(
                    builder: _buildSwitch),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(
      BuildContext context,
      NotificationPreferenceProvider provider,
      SchedulingProvider scheduler,
      Widget? _) {
    return Switch.adaptive(
      value: provider.isDailyRecommendationActive,
      onChanged: (value) {
        if (Platform.isIOS) {
          comingSoonDialog(context);
        } else {
          scheduler.scheduleDailyRecommendation(value);
          provider.toggleDailyRecommendationPreference(value);
        }
      },
    );
  }

  void comingSoonDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
