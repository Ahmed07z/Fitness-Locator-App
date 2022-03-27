import 'package:fitnesslocator/Admin/LoginAdmin.dart';
import 'package:fitnesslocator/FitnessOwner/LoginOwner.dart';
import 'package:fitnesslocator/User/HomeUser.dart';
import 'package:fitnesslocator/User/LoginUser.dart';
import 'package:fitnesslocator/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? currentLoginState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(mainwallpaper),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 140.0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('FitnessLocator',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87),
                      minimumSize: MaterialStateProperty.all(Size(350.0, 50.0)),
                    ),
                    onPressed: () {
                      Navigator?.push(context,
                          MaterialPageRoute(builder: (context) => LoginUser()));
                    },
                    child: const Text(
                      'User',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87),
                      minimumSize: MaterialStateProperty.all(Size(350.0, 50.0)),
                    ),
                    onPressed: () {
                      Navigator?.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginOwner()));
                    },
                    child: const Text(
                      'Fitness Owner',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87),
                      minimumSize: MaterialStateProperty.all(Size(350.0, 50.0)),
                    ),
                    onPressed: () {
                      Navigator?.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginAdmin()));
                    },
                    child: const Text(
                      'Admin',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    
  }
}
