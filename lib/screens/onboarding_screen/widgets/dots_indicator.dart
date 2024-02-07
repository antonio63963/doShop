import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotsIndicator extends StatelessWidget {
  final int index;
  final PageController controller;
  final Function() onClose;

  const DotsIndicator({
    super.key,
    required this.index,
    required this.controller,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, .55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: index != 0
                ? () => controller.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn)
                : () {},
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 32,
              color: index != 0
                  ? MyColors.white
                  : const Color.fromARGB(159, 202, 202, 202),
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const WormEffect(
              dotColor: MyColors.white,
              activeDotColor: MyColors.primary,
              dotWidth: 10,
              dotHeight: 10,
            ),
          ),
          //to Next
          index != 2
              ? IconButton(
                  onPressed: () {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  icon: const Icon(Icons.chevron_right_rounded,
                      size: 32, color: MyColors.white),
                )
              : IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.done_rounded,
                    size: 32,
                    color: MyColors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
