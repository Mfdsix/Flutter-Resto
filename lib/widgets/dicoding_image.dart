import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DicodingImage extends StatelessWidget {
  final String imageId;

  const DicodingImage({Key? key, required this.imageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageId,
      width: 100,
    );
  }
}
