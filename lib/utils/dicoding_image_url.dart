enum ImageSize { small, medium, large }

String getDicodingImageURL(String pictureId,
    [ImageSize resolution = ImageSize.medium]) {
  String baseUrl = 'https://restaurant-api.dicoding.dev/images';
  return "$baseUrl/${resolution.name}/$pictureId";
}
