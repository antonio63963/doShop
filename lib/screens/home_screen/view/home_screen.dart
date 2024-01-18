import 'package:doshop_app/forms/user_template_form/user_temlate_form.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:doshop_app/db/exports.dart';

import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/forms/shoping_list_form/shoping_list_form.dart';
import 'package:doshop_app/screens/home_screen/view/content/shoping_lists.dart/shoping_lists_screen.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/categories_page.dart';
import 'package:doshop_app/screens/home_screen/view/content/templates_page/templates_page.dart';

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
          leading: Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 5),
            child: ElevatedButton(
                onPressed: () => LocalDB.instance.deleteDB(),
                child: const Text('Delete')),
          ),
          title: Text(getTitle()),
        ),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: getFabByTab(context, _currentTab),
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

Widget? getFabByTab(BuildContext context, int currentTab) {
  if (currentTab == 0) return null;
  switch (currentTab) {
    case 0:
      return null;
    case 1:
      return FAB(
        onClick: () => showModal(context, const UserTemplateForm()),
        icon: Icons.add,
      );
    case 2:
      return FAB(
        onClick: () => showModal(context, const ShoppingListForm()),
        icon: Icons.add,
      );
    default:
      return null;
  }
}
