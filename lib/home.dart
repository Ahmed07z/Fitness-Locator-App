import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnesslocator/Admin/LoginAdmin.dart';
import 'package:fitnesslocator/GymOwner/HomeOwner.dart';
import 'package:fitnesslocator/GymOwner/RegisterForm.dart';
import 'package:fitnesslocator/Member/LoginMember.dart';
import 'package:fitnesslocator/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
final gymOwnerReference = FirebaseFirestore.instance.collection("gymOwner");
final promotionReference = FirebaseFirestore.instance.collection("promotion");
DocumentSnapshot? currentUser;
final FirebaseStorage storage = FirebaseStorage.instance;
final Reference storageReference = storage.ref().child("Post Pictures");

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool? isSignedIn;
  bool? isLoading;
  bool? registered;

  logInUser() async {
    isLoading = true;
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
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  saveUserInfoToFirestore() async {
    final GoogleSignInAccount? gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await gymOwnerReference.doc(gCurrentUser?.id).get();

    if (!documentSnapshot.exists) {
      gymOwnerReference.doc(gCurrentUser?.id).set({
        "id": gCurrentUser?.id,
        "profileName": gCurrentUser?.displayName,
        "photoUrl": gCurrentUser?.photoUrl,
        "email": gCurrentUser?.email,
        "type": "GymOwner",
        "formRegister": "Notregistered"
      });
      documentSnapshot = await gymOwnerReference.doc(gCurrentUser?.id).get();
    }
    DocumentSnapshot GymInfo = await gymOwnerReference
        .doc(gCurrentUser?.id)
        .collection("FitnessCenterDetails")
        .doc(gCurrentUser?.id)
        .get();
    if (!GymInfo.exists) {
      registered = false;
    } else {
      gymOwnerconstant = GymInfo;
      registered = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn == true) {
      if (registered == true) {
        return HomeGymOwner();
      } else {
        return Formtest();
      }
    } else {
      return isLoading == true
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              ),
            )
          : Scaffold(
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
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2936/2936886.png',
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text('FitnessLocator',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.08,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: FlatButton(
                            color: Colors.white,
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: const Text('Gym Owner',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            onPressed: () async {
                              logInUser();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: FlatButton(
                            color: Colors.white,
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: const Text('Gym Member',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            onPressed: () async {
                              Navigator?.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginMember()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 16, top: 20, left: 20, right: 20),
                          width: double.infinity,
                          child: FlatButton(
                            child: const Text(
                              'Are you an Admin ? Click here',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator?.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginAdmin()));
                            },
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
}
