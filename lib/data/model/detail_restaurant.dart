// To parse this JSON data, do
//
//     final detailRestaurantResponse = detailRestaurantResponseFromJson(jsonString);

import 'dart:convert';

DetailRestaurantResponse detailRestaurantResponseFromJson(String str) => DetailRestaurantResponse.fromJson(json.decode(str));

String detailRestaurantResponseToJson(DetailRestaurantResponse data) => json.encode(data.toJson());

class DetailRestaurantResponse {
    bool error;
    String message;
    Restaurant restaurant;

    DetailRestaurantResponse({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) => DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}

class Restaurant {
    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    List<Category>? categories;
    Menus? menus;
    double? rating;
    List<CustomerReview>? customerReviews;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        this.categories,
        this.menus,
        this.rating,
        this.customerReviews,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(json["categories"]?.map((x) => Category.fromJson(x)) ?? []),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"]?.map((x) => CustomerReview.fromJson(x)) ?? []),
    );

    factory Restaurant.fromDB(Map<String, dynamic> map) => Restaurant(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        city: map["city"],
        address: map["address"],
        pictureId: map["pictureId"]
    );

    Map<String, dynamic> toDB() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
    };

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": categories != null ? List<dynamic>.from(categories!) : [],
        "menus": menus != null ? menus?.toJson() : [],
        "rating": rating,
        "customerReviews": customerReviews != null ? List<dynamic>.from(customerReviews!) : [],
    };
}

class Category {
    String name;

    Category({
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class CustomerReview {
    String name;
    String review;
    String date;

    CustomerReview({
        required this.name,
        required this.review,
        required this.date,
    });

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}

class Menus {
    List<Category> foods;
    List<Category> drinks;

    Menus({
        required this.foods,
        required this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"]?.map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"]?.map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}
