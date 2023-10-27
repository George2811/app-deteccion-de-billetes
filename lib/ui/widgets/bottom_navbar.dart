import 'package:counterfeit_detector/colors.dart';
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
          icon: const Icon(Icons.home_outlined),
          title: ("Inicio"),
          activeColorPrimary: alternative,
          inactiveColorPrimary: dark[200],
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.compare),
          title: ("Detector"),
          activeColorPrimary: alternative,
          inactiveColorPrimary: dark[200],
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.feed_outlined),
          title: ("Guías"),
          activeColorPrimary: alternative,
          inactiveColorPrimary: dark[200],
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
      backgroundColor:Color(0xFFEEFFF6), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarHeight: 70,
      padding: const NavBarPadding.only(bottom: 20),
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
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}