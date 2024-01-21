import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  final String jsonAnimation;
  const IntroPage({super.key, required this.jsonAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A72C3),
      child: Lottie.asset(jsonAnimation),
    );
  }
}
