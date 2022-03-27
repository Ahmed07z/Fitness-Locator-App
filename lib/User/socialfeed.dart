import 'package:fitnesslocator/User/LoginUser.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';

class SocialFeed extends StatefulWidget {
  @override
  State<SocialFeed> createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  logOutUser() {
    gSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 108.0),
          child: Column(
            children: [
              Container(
                child: TextButton(
                    onPressed: () {
                      logOutUser();
                      Navigator?.push(context,
                          MaterialPageRoute(builder: (context) => home()));
                    },
                    child: Text(
                      "logout",
                      style: TextStyle(fontSize: 25.0),
                    )),
              ),
              CircleAvatar(
                minRadius: 150.0,
                backgroundImage: NetworkImage(currentUser!['photoUrl']),
              ),
              Text(currentUser!['profileName'])
            ],
          ),
        ),
      ),
    );
  }
}
