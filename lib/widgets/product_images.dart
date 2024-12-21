import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget productImages(List<String>? images) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: images?.length,
    itemBuilder: (context, index) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: images![index],
            fit: BoxFit.fill,
          ),
        ),
      );
    },
  );
}
