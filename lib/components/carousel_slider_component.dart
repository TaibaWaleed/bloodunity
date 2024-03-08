import 'package:bloodunity/model/ui_model/carousel_slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

///CarouselSlider
carouselSliderMethod() {
  return CarouselSlider(
    items: carouselSliderModel.map((carouselModelValue) {
      return Card(
        child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: Image.network(carouselModelValue.imageUrl.toString(),
                        fit: BoxFit.fitHeight)),
              ],
            )),
      );
    }).toList(),
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 12 / 9,
      initialPage: 0,
    ),
  );
}
