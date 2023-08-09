import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/dicoding_image.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
        title: Text(
          restaurant.name,
          style: const TextStyle(color: whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: DicodingImage(imageId: restaurant.pictureId)),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
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
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(restaurant.city)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(restaurant.rating.toString())
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuSection(String title, List<Drink> menus) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 50,
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 160,
            ),
            child: Container(
              color: greyColor,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Text(menu,
                        style:
                            const TextStyle(color: primaryColor, fontSize: 16)),
                  )),
            )));
  }
}
