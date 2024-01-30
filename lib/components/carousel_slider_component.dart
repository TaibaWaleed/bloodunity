import 'package:bloodunity/model/ui_model/carousel_slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

///CarouselSlider
carouselSliderComponent() {
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
                Expanded(
                  child: Text(
                    carouselModelValue.tips.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      );
    }).toList(),
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 16 / 10,
      initialPage: 0,
    ),
  );
}
