import 'package:fitnesslocator/GymOwner/ApprovedPromotions.dart';
import 'package:fitnesslocator/GymOwner/GymProfile.dart';
import 'package:fitnesslocator/GymOwner/RequestPromotion.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';

class HomeGymOwner extends StatefulWidget {
  @override
  State<HomeGymOwner> createState() => _HomeGymOwnerState();
}

class _HomeGymOwnerState extends State<HomeGymOwner> {
  int currentIndex = 0;

  final screens = [
    gymProfle(
      gymProfileId: '${gSignIn.currentUser?.id}',
    ),
    requestPromotion(),
    ApprovedPromotion()
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.lightBlue[900],
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
                icon: Icon(Icons.add),
                label: 'Create Promo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_rounded),
                label: 'Promos',
              )
            ],
          )),
    );
  }
}
