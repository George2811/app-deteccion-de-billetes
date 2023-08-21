import 'package:counterfeit_detector/state/appdata.dart';
import 'package:counterfeit_detector/ui/views/guide.dart';
import 'package:counterfeit_detector/ui/views/home.dart';
import 'package:counterfeit_detector/ui/views/select_currency.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBar extends StatefulWidget {

  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    //bool show = appData.showNavBar;

    List<Widget> _buildScreens() {
      return [
        const HomeView(),
        const SelectCurrency(),
        const GuideView()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          //title: ("Home"),
          activeColorPrimary: const Color.fromARGB(255, 1, 24, 7),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.compare, color: Color.fromARGB(255, 0, 234, 37),),
          //title: ("Detección"),
          activeColorPrimary: const Color.fromARGB(255, 1, 24, 7),
          inactiveColorPrimary: const Color.fromARGB(255, 1, 24, 7),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.feed_outlined),
          //title: ("Guía"),
          activeColorPrimary: const Color.fromARGB(255, 1, 24, 7),
          inactiveColorPrimary: Colors.grey
        ),
      ];
    }
    
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      hideNavigationBar: appData.showNavBar,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}