import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class requestPromotion extends StatefulWidget {
  requestPromotion({Key? key}) : super(key: key);

  @override
  State<requestPromotion> createState() => _requestPromotionState();
}

class _requestPromotionState extends State<requestPromotion> {
  TextEditingController TitleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  String postId = Uuid().v4();
  bool? isSaving = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget? TitleField() {
    return Container(
      child: TextFormField(
        maxLength: 20,
        controller: TitleController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Title Required';
          }
        },
        onSaved: (String? value) {},
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.title_outlined,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,

          hintText: "Title",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Title',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget? DescriptionField() {
    return Container(
      child: TextFormField(
        maxLength: 40,
        controller: DescriptionController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Description';
          }
        },
        onSaved: (String? value) {},
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.description_outlined,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,

          hintText: "Description",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Description',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  FormInformationStored() async {
    setState(() {
      isSaving = true;
    });

    DocumentSnapshot GymInfo = await gymOwnerReference
        .doc(gSignIn.currentUser?.id)
        .collection("FitnessCenterDetails")
        .doc(gSignIn.currentUser?.id)
        .get();

    String centerName = GymInfo['centername'];

    promotionReference.doc(gSignIn.currentUser?.id).collection('promos').add({
      'title': TitleController.text,
      'description': DescriptionController.text,
      'Approved': false,
      'Owned By': gSignIn.currentUser?.id,
      'centername': centerName
    });

    final snackBar = SnackBar(
      content: Text('Promotion Sent For Approval'),
      duration: Duration(seconds: 2),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    TitleController.clear();
    DescriptionController.clear();
    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('Create Promotion'),
        centerTitle: true,
      ),
      body: isSaving == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                    key: _formkey,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 12, right: 12, bottom: 12),
                              child: TitleField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DescriptionField(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: double.infinity,
                              child: FlatButton(
                                color: Colors.lightBlue[800],
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: const Text('Save',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () {
                                  if (!_formkey.currentState!.validate()) {
                                    AlertDialog(
                                      title: Text('Fill All Info!'),
                                    );
                                    return;
                                  }
                                  FormInformationStored();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
    );
  }
}
