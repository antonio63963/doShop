
import 'package:doshop_app/db/exports.dart';
import 'package:doshop_app/screens/home_screen/view/content/Lists_page.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page.dart';
import 'package:doshop_app/screens/home_screen/view/content/templates_page.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = true;
  bool isInit = false;
  int _currentTab = 0;

  String getTitle() {
    if (_currentTab == 0) {
      return 'Категории';
    } else if (_currentTab == 1) {
      return 'Шаблоны';
    } else {
      return 'Списки';
    }
  }


  final List<Widget> _pages = [
    const CategoriesPage(),
    const TemplatesPage(),
    const ListsPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const CategoriesPage();

  void setScreen(Widget screen, int tabInd) {
    setState(
      () {
        currentScreen = screen;
        _currentTab = tabInd;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading:  Padding(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 5),
            child: ElevatedButton(onPressed: () => LocalDB.instance.deleteDB(), child: Text('Delete')),
          ),
          title: Text(getTitle()),
        ),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        
        bottomNavigationBar: BottomAppBar(
          color: MyColors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TabButton(
                  title: 'Категории',
                  setScreen: setScreen,
                  currentTab: _currentTab,
                  tabIndex: 0,
                  screen: _pages[0],
                  buttonPadding: const EdgeInsets.only(right: 20),
                  svgPath: 'assets/icons/categories.svg',
                ),
                TabButton(
                  title: 'Шаблоны',
                  setScreen: setScreen,
                  currentTab: _currentTab,
                  tabIndex: 1,
                  screen: _pages[1],
                  buttonPadding: const EdgeInsets.only(left: 20),
                  svgPath: 'assets/icons/templates.svg',
                ),
                TabButton(
                  title: 'Списки',
                  setScreen: setScreen,
                  currentTab: _currentTab,
                  tabIndex: 2,
                  screen: _pages[2],
                  buttonPadding: const EdgeInsets.only(left: 20),
                  svgPath: 'assets/icons/lists.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}