import 'package:fitnesslocator/User/LoginUser.dart';
import 'package:fitnesslocator/User/socialfeed.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  int currentIndex = 0;

  final screens = [
    SocialFeed(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blueGrey,
            iconSize: 35,
            selectedFontSize: 15,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.announcement_outlined),
                label: 'Promotions',
              )
            ],
          )),
    );
  }
}
