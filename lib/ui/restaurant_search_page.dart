import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/search_restaurant.dart';
import 'package:flutter_restaurant/provider/search_restaurant_provider.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_restaurant/utils/dicoding_image_url.dart';
import 'package:flutter_restaurant/utils/result_state.dart';
import 'package:flutter_restaurant/widgets/custom_message.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_search';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, provider, _) {
          return _buildAppBar(provider);
        },
      ),
    );
  }

  Widget _buildAppBar(SearchRestaurantProvider provider) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(color: primaryColor),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.fetchData(value);
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              hintText: "Search Restaurant",
            ),
          ),
        ),
      ),
      body: _buildList(provider),
    );
  }

  Widget _buildList(SearchRestaurantProvider provider) {
    return Builder(builder: (context) {
      if (provider.state == ResultState.standBy) {
        return const CustomMessage(
            message: "Looking for Best Restaurant ?",
            assetPath: "assets/search.png");
      } else if (provider.state == ResultState.loading) {
        return const CustomMessage(
            message: "searching...", assetPath: "assets/loading.png");
      } else if (provider.state == ResultState.error) {
        return CustomMessage(
            message: provider.message, assetPath: "assets/no-data.png");
      } else if (provider.state == ResultState.noData) {
        return const CustomMessage(
            message: "No Restaurant Found", assetPath: "assets/no-data.png");
      }

      return ListView.builder(
          itemCount: provider.result.length,
          itemBuilder: (context, index) {
            return _buildSearchItem(context, provider.result[index]);
          });
    });
  }

  Widget _buildSearchItem(BuildContext context, Restaurant restaurant) {
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
                  getDicodingImageURL(restaurant.pictureId),
                ),
              ),
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
              arguments: restaurant.id);
        },
      ),
    );
  }
}
