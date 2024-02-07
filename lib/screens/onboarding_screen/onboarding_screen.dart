import 'package:doshop_app/screens/onboarding_screen/widgets/dont_show_button.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/screens/onboarding_screen/widgets/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/app_bar_intro.dart';
import 'widgets/dots_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  final Function() onClose;
  const OnBoardingScreen({super.key, required this.onClose});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarIntro(onClose: widget.onClose),
        body: Stack(
          children: [
            //page view
            PageView(
              controller: _controller,
              onPageChanged: (index) => setState(() {
                _index = index;
              }),
              children: const [
                IntroPage(jsonAnimation: 'assets/animation/page1.json'),
                IntroPage(jsonAnimation: 'assets/animation/page2.json'),
                IntroPage(jsonAnimation: 'assets/animation/page3.json'),
              ],
            ),
            //dots indicators
            DotsIndicator(
              index: _index,
              controller: _controller,
              onClose: widget.onClose,
            ),
            if(_index == 2)
            DontShowButton(setNotShown: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool('isShownIntro', false);
                widget.onClose();
              });
            })
          ],
        ));
  }
}
