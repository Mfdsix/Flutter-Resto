import 'dart:io';

import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/provider/home_tab_provider.dart';
import 'package:flutter_restaurant/ui/home/restaurant_list.dart';
import 'package:flutter_restaurant/ui/home/settings.dart';
import 'package:flutter_restaurant/ui/home/restaurant_favorite.dart';
import 'package:flutter_restaurant/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  HomePage({Key? key}): super(key: key);

  static const routeName = '/home_page';

  final List<Widget> _listWidget = [
    const RestaurantList(),
    const RestaurantFavorite(),
    const Settings(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.cube_fill : Icons.restaurant),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.heart_circle : Icons.favorite),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: Settings.settingsTitle,
    ),
  ];

  Widget _buildAndroid(BuildContext context, HomeTabProvider provider) {
    return Scaffold(
      body: _listWidget[provider.navIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: provider.navIndex,
        items: _bottomNavBarItems,
        onTap: (int newIndex) => provider.setNavIndex(newIndex),
      ),
    );
  }

  Widget _buildIos(BuildContext context, HomeTabProvider provider) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: primaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabProvider>(builder: (context, provider, _) {
      return PlatformWidget(
        androidBuilder: (BuildContext context) => _buildAndroid(context, provider),
        iosBuilder: (BuildContext context) => _buildIos(context, provider),
      );
    });
  }
}
