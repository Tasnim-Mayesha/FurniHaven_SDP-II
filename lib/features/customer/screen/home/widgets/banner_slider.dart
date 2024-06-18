import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerSlider extends StatelessWidget {
  final List<String> imgList = [
    'assets/banner/banner1.png',
    'assets/banner/banner2.png',
    'assets/banner/banner3.png',
  ];

  BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) => Container(
        child: Center(
          child: Image.asset(item, fit: BoxFit.cover, width: 1000),
        ),
      )).toList(),
    );
  }
}
