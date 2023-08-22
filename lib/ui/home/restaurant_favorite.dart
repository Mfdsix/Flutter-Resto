import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/data/model/detail_restaurant.dart';
import 'package:flutter_restaurant/provider/database_provider.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_restaurant/ui/restaurant_search_page.dart';
import 'package:flutter_restaurant/utils/dicoding_image_url.dart';
import 'package:flutter_restaurant/utils/result_state.dart';
import 'package:flutter_restaurant/widgets/custom_message.dart';
import 'package:flutter_restaurant/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantFavorite extends StatelessWidget {
  const RestaurantFavorite({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const CustomMessage(
            message: "loading...", assetPath: "assets/loading.png");
      } else if (state.state == ResultState.error) {
        return CustomMessage(
            message: state.message, assetPath: "assets/no-data.png");
      } else if (state.state == ResultState.noData) {
        return const CustomMessage(
            message: "No Restaurant Data", assetPath: "assets/no-data.png");
      }

      return ListView.builder(
          itemCount: state.result.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, state.result[index]);
          });
    });
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 200,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                getDicodingImageURL(restaurant.pictureId),
              ),
            ),
          ),
        ),
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
                  style: const TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant.id);
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorite',
          style: TextStyle(color: whiteColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: whiteColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('My Favorite'),
        transitionBetweenRoutes: false,
        trailing: IconButton(
          icon: const Icon(
            Icons.search,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, RestaurantSearchPage.routeName);
          },
        ),
      ),
      child: _buildList(),
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
