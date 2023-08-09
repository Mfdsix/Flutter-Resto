import 'package:flutter/services.dart';
import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_restaurant/widgets/dicoding_image.dart';
import 'package:flutter_restaurant/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString('assets/restaurants.json'),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final RestaurantResponse restaurantResponse =
              restaurantResponseFromJson(snapshot.data ?? "{}");
          final List<Restaurant> restaurants = restaurantResponse.restaurants;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        } else {
          return const Text("Invalid JSON");
        }
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Hero(
            tag: restaurant.pictureId,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 200,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: DicodingImage(imageId: restaurant.pictureId)),
            )),
        title: Text(restaurant.name,
            style: const TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              restaurant.city,
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Puth Food',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Puth Food'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
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
