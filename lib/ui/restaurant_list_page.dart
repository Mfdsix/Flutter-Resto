import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/data/model/list_restaurant.dart';
import 'package:flutter_restaurant/provider/get_all_restaurant_provider.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_restaurant/utils/dicoding_image_url.dart';
import 'package:flutter_restaurant/utils/result_state.dart';
import 'package:flutter_restaurant/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList() {

    return Consumer<GetAllRestaurantProvider>(
      builder: (context, state, _) {
        if(state.state == ResultState.loading){
          return const Center(child: CircularProgressIndicator());
        }else if(state.state == ResultState.error){
          return Center(child: Text(state.message));
        }else if(state.state == ResultState.noData){
          return Center(child: Text(state.message));
        }

        return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, state.result[index]);
            }
        );
      }
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
                  child: Image.network(
                    getDicodingImageURL(restaurant.pictureId)
                  )),
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
                  style: const TextStyle(fontSize: 12),
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
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Puth Food'),
        transitionBetweenRoutes: false,
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
