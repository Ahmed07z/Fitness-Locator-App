import 'package:fitnesslocator/GymOwner/HomeOwner.dart';
import 'package:fitnesslocator/Member/HomeMember.dart';
import 'package:fitnesslocator/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginMember extends StatefulWidget {
  LoginMember({Key? key}) : super(key: key);

  @override
  State<LoginMember> createState() => _LoginOwnerState();
}

class _LoginOwnerState extends State<LoginMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('User SignIn'),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(LoginOwnerWallpaper),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SignInButton(
                    Buttons.Google,
                    text: "Signin with Google",
                    onPressed: () {
                      Navigator?.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMember()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
