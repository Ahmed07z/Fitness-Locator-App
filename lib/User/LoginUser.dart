import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesslocator/User/HomeUser.dart';
import 'package:fitnesslocator/User/socialfeed.dart';
import 'package:fitnesslocator/constants.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
final userReference = FirebaseFirestore.instance.collection("users");
DocumentSnapshot? currentUser;

class LoginUser extends StatefulWidget {
  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  bool? isSignedIn;

  logInUser() async {
    gSignIn.signIn();
  }

  logOutUser() {
    gSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: (gError) {
      print("Error Message: " + gError);
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }).catchError((gError) {
      print("Error Message: " + gError);
    });
  }

  controlSignIn(GoogleSignInAccount? signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFirestore();
      setState(() {
        isSignedIn = true;
      });
      // debugPrint(isSignedIn.toString());
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  saveUserInfoToFirestore() async {
    final GoogleSignInAccount? gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await userReference.doc(gCurrentUser?.id).get();

    if (!documentSnapshot.exists) {
      userReference.doc(gCurrentUser?.id).set({
        "id": gCurrentUser?.id,
        "profileName": gCurrentUser?.displayName,
        "photoUrl": gCurrentUser?.photoUrl,
        "email": gCurrentUser?.email,
        "type": "User"
      });
      documentSnapshot = await userReference.doc(gCurrentUser?.id).get();
    }
    setState(() {
      currentUser = documentSnapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn == true) {
      return HomeUser();
    } else {
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
                image: NetworkImage(LoginUserWallpaper),
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
                        logInUser();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        logOutUser();
                        Navigator?.push(context,
                            MaterialPageRoute(builder: (context) => home()));
                      },
                      child: Text(
                        "logout",
                        style: TextStyle(fontSize: 25.0),
                      ))
                ],
              ),
            ),
          ));
    }
  }
}
