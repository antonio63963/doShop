import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabButton extends StatelessWidget {
  final String title;
  final Function(Widget, int) setScreen;
  final int currentTab;
  final Widget screen;
  final int tabIndex;
  final EdgeInsets buttonPadding;
  final IconData? icon;
  final String? svgPath;
  const TabButton({
    super.key,
    required this.title,
    required this.setScreen,
    required this.currentTab,
    required this.screen,
    required this.tabIndex,
    required this.buttonPadding,
    this.icon,
    this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor = MyColors.accent;
    Color notActiveColor = MyColors.primary;

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            padding: buttonPadding,
            minWidth: 40,
            onPressed: () => setScreen(screen, tabIndex),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (icon != null)
                  Icon(
                    icon,
                    color:
                        currentTab == tabIndex ? activeColor : notActiveColor,
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (svgPath != null) SvgPicture.asset(svgPath!, colorFilter: ColorFilter.mode(currentTab == tabIndex ? activeColor : notActiveColor, BlendMode.srcIn),),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        currentTab == tabIndex ? activeColor : notActiveColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
