import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesslocator/GymOwner/EditGymProfile.dart';
import 'package:fitnesslocator/home.dart';
import 'package:fitnesslocator/widgets/ShowImageFullSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class gymProfle extends StatefulWidget {
  final String gymProfileId;
  gymProfle({required this.gymProfileId});

  @override
  State<gymProfle> createState() => _gymProfleState();
}

class _gymProfleState extends State<gymProfle> {
  logOutUser() {
    gSignIn.signOut();
  }

  _callNumber(phoneNum) async {
    String number = phoneNum;
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  CreatePopup(mContext, heading) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Edit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
                onPressed: () {
                  Navigator?.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditGymProfile()));
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          title: Text('Fitness Center'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                logOutUser();
                AlertDialog(
                  title: Text('Logout'),
                );
                Navigator?.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => home()));
              },
              icon: Icon(Icons.logout_sharp),
            )
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: gymOwnerReference
              .doc(widget.gymProfileId)
              .collection("FitnessCenterDetails")
              .doc(widget.gymProfileId)
              .get(),
          builder: (context, dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    ListTile(
                      visualDensity:
                          VisualDensity(horizontal: 3.0, vertical: 3.0),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SliderShowFullmages(
                                  listImagesModel:
                                      dataSnapshot.data!.get('Images'),
                                  current: 0)));
                        },
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage: CachedNetworkImageProvider(
                              dataSnapshot.data!.get('Images')[0]),
                        ),
                      ),
                      title: Text(
                        dataSnapshot.data!.get('centername'),
                        style: TextStyle(
                            color: Colors.lightBlue[900],
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Owned By: ${dataSnapshot.data!.get('name')}',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            CreatePopup(context, 'Info');
                          },
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.grey[700],
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Divider(
                      color: Colors.grey.shade700,
                    ),
                    InkWell(
                      onTap: () {
                        print("Tap");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.info_outline),
                          title: Text(
                              ' ${dataSnapshot.data!.get('Category')} (${dataSnapshot.data!.get('Gender')})'
                                  .toUpperCase()),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.money),
                          title: Text(
                              '${dataSnapshot.data!.get('MonthFee')} RS per month'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('${dataSnapshot.data!.get('address')}'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.watch_later_outlined),
                          title: Text(
                              '${dataSnapshot.data!.get('opentime')} to ${dataSnapshot.data!.get('closetime')}'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.email_outlined),
                          title: Text('${dataSnapshot.data!.get('email')}'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _callNumber('${dataSnapshot.data!.get('phone')}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          selected: true,
                          selectedTileColor: Colors.grey[300],
                          leading: Icon(Icons.phone),
                          title: Text('${dataSnapshot.data!.get('phone')}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
    ;
  }
}
