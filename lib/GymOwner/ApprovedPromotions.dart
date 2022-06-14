import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesslocator/GymOwner/GymProfile.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';

class ApprovedPromotion extends StatefulWidget {
  @override
  State<ApprovedPromotion> createState() => _ApprovedPromotionState();
}

class _ApprovedPromotionState extends State<ApprovedPromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('Promotions'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: promotionReference
            .doc(gSignIn.currentUser?.id)
            .collection("promos")
            .get(),
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (dataSnapshot.hasData) {
            return ListView.builder(
                itemCount: dataSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator?.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => gymProfle(
                                      gymProfileId:
                                          '${dataSnapshot.data!.docs[index]['Owned By']}',
                                    )));
                      },
                      child: ListTile(
                        selected: true,
                        selectedTileColor:
                            dataSnapshot.data!.docs[index]['Approved'] == true
                                ? Colors.grey[300]
                                : Colors.red[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        leading: Text(
                          '${dataSnapshot.data!.docs[index]['centername']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        title:
                            Text('${dataSnapshot.data!.docs[index]['title']}'),
                        subtitle: Text(
                            '${dataSnapshot.data!.docs[index]['description']}'),
                        trailing: Icon(
                          Icons.percent_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: Text('No Active Promotions'));
          }
        },
      ),
    );
  }
}
