import 'package:fitnesslocator/constants.dart';
import 'package:flutter/material.dart';

class HomeOwner extends StatefulWidget {
  HomeOwner({Key? key}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  late String ownerName;
  late String fitnessCenterName;
  late String email;
  late String phoneno;
  late String timings;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget? _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Name:',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
      },
      onSaved: (String? value) {
        ownerName = value!;
      },
    );
  }

  Widget? _buildCenterNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Fitness Center Name:',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return ' Center Name is required';
        }
      },
      onSaved: (String? value) {
        fitnessCenterName = value!;
      },
    );
  }

  Widget? _buildemailField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String? value) {
        email = value!;
      },
    );
  }

  Widget? _buildphonenoField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number:',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return ' Phoneno is required';
        }
      },
      onSaved: (String? value) {
        phoneno = value!;
      },
    );
  }

  Widget? _buildtimingsField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Timings:',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return ' Center Timing is required';
        }
      },
      onSaved: (String? value) {
        fitnessCenterName = value!;
      },
    );
  }

  Widget? _buildEquipmentField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Equipments:',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(2.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Equipments Details are required';
        }
      },
      onSaved: (String? value) {
        fitnessCenterName = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // appBar: AppBar(title: Text("Fitness Center Registeration"),backgroundColor: Colors.black,),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 7.0, left: 7.0, bottom: 20),
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(LoginOwnerWallpaper),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Register Your Center',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, left: 12, right: 12, bottom: 12),
                        child: _buildNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildCenterNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildemailField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildphonenoField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildtimingsField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildEquipmentField(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[400]),
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                                right: 50.0, left: 50.0, top: 10, bottom: 10))),
                        onPressed: () {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          ;
                          _formkey.currentState!.save();
                          print(ownerName);
                          // print(fitnessCenterName);
                          // print(email);
                          // print(phoneno);
                        },
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
