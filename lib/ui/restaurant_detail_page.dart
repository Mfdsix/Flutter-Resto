import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/detail_restaurant.dart';
import 'package:flutter_restaurant/provider/get_restaurant_by_id_provider.dart';
import 'package:flutter_restaurant/utils/dicoding_image_url.dart';
import 'package:flutter_restaurant/utils/result_state.dart';
import 'package:flutter_restaurant/widgets/custom_message.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail_page';

  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          title: const Text(
            "Puth Food",
            style: TextStyle(color: whiteColor),
          ),
        ),
        body: ChangeNotifierProvider<GetRestaurantByIdProvider>(
          create: (_) => GetRestaurantByIdProvider(
              apiService: ApiService(), restaurantId: widget.restaurantId),
          child: _buildDetail(),
        ));
  }

  Widget _buildDetail() {
    return Consumer<GetRestaurantByIdProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const CustomMessage(
            message: "loading...", assetPath: "assets/loading.png");
      } else if (state.state == ResultState.error) {
        return CustomMessage(
            message: state.message, assetPath: "assets/no-data.png");
      }

      return buildRestaurantDetail(context, state.result);
    });
  }

  Widget buildMenuSection(String title, List<Category> menus) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: menus.length,
          itemBuilder: (context, index) {
            return buildMenuItem(menus[index].name);
          },
          scrollDirection: Axis.horizontal,
        ),
      )
    ]);
  }

  Widget buildMenuItem(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 200,
        // color: greyColor,
        decoration: const BoxDecoration(
          color: secondaryColor,
          image: DecorationImage(
            image: AssetImage('assets/no-data.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              menu,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantDetail(BuildContext context, Restaurant restaurant) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
              tag: restaurant.pictureId,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                    getDicodingImageURL(restaurant.pictureId),
                  ),
                ),
              )),
          Column(children: [
            Container(
              color: greyColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.place,
                          color: primaryColor,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant.city,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(restaurant.description)),
            buildMenuSection("Menu Makanan", restaurant.menus.foods),
            const SizedBox(
              height: 10,
            ),
            buildMenuSection("Menu Minuman", restaurant.menus.drinks),
            const SizedBox(
              height: 50,
            ),
          ]),
        ],
      ),
    );
  }
}
