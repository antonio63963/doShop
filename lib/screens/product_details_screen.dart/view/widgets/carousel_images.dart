import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:doshop_app/utils/photo.service.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

class CarouselImages extends StatefulWidget {
  final Product product;
  const CarouselImages({super.key, required this.product});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.product.photos!.length < 2
        ? Card(
            child: SizedBox(
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: PhotoService.imageFromBase64String(
                    widget.product.photos![0].photo),
              ),
            ),
          )
        : Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: widget.product.photos!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: PhotoService.imageFromBase64String(i.photo),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              buildIndicator(),
            ],
          );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: MyColors.primary,
        ),
        activeIndex: activeIndex,
        count: widget.product.photos!.length,
      );
}
