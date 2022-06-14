// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnesslocator/GymOwner/HomeOwner.dart';
import 'package:fitnesslocator/constants.dart';
import 'package:fitnesslocator/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';

class Formtest extends StatefulWidget {
  Formtest({Key? key}) : super(key: key);

  @override
  State<Formtest> createState() => _FormtestState();
}

class _FormtestState extends State<Formtest> {
  TextEditingController OwnernameController = TextEditingController();
  TextEditingController CenternameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController EquipmentController = TextEditingController();
  TextEditingController MonthlyController = TextEditingController();
  TextEditingController LatitudeController = TextEditingController();
  TextEditingController LongitudeController = TextEditingController();
  TextEditingController FitnessCenterController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  late String ownerName;
  late String fitnessCenterName;
  late String email;
  late String phoneno;
  late String timings;
  var selectedCity;
  List tags = [];
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  TextEditingController timeinputopen = TextEditingController();
  TextEditingController timeinputclose = TextEditingController();
  String? _myActivity;
  String? _myActivityGender;
  String? _myActivityCity;
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  String postId = Uuid().v4();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Widget? _buildNameField() {
    return Container(
      child: TextFormField(
        controller: OwnernameController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Owner Name Required';
          }
        },
        onSaved: (String? value) {
          ownerName = value!;
        },
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.person_outline_rounded,
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

          hintText: "Owner Name",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Owner Name',
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

  Widget? _buildCenterNameField() {
    return Container(
      child: TextFormField(
        controller: CenternameController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Fitness Center Name Required';
          }
        },
        onSaved: (String? value) {
          fitnessCenterName = value!;
        },
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.sports_baseball_outlined,
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
          hintText: "Fitness Center Name",
          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Fitness Center Name',
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

  Widget? _buildAddressField() {
    return Container(
      child: TextFormField(
        controller: AddressController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Address is Required';
          }
        },
        onSaved: (String? value) {
          fitnessCenterName = value!;
        },
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.edit_location_alt_outlined,
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
          hintText: "Address",
          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Address',
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

  Widget? _buildemailField() {
    return Container(
      child: TextFormField(
        controller: EmailController,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Email Required';
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
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.email_outlined,
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
          hintText: "Email",
          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Email',
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

  Widget? _buildphonenoField() {
    return Container(
        child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: PhoneController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Phone No. Required';
              }

              if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
                return 'Please enter a valid Phone number';
              }

              return null;
            },
            onSaved: (String? value) {
              phoneno = value!;
            },
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              focusColor: Colors.white,
              //add prefix icon
              prefixIcon: Icon(
                Icons.phone,
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
              hintText: "Phone No.",
              //make hint text
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),

              //create lable
              labelText: 'Phone No.',
              //lable style
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),
            )));
  }

  Widget? _buildtimingsField() {
    return Flexible(
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Add Opening Time';
          }
        },
        controller: timeinputopen, //editing controller of this TextField
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.lock_open, color: Colors.grey), //icon of text field
          labelText: "Enter Opening Time",
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), //label text of field
        ),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            print(pickedTime.format(context)); //output 10:51 PM
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
            //converting to DateTime so that we can further format on different pattern.
            print(parsedTime); //output 1970-01-01 22:53:00.000
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
            print(formattedTime); //output 14:59:00
            //DateFormat() is from intl package, you can format the time on any pattern you need.

            setState(() {
              timeinputopen.text = formattedTime; //set the value of text field.
            });
          } else {
            print("Time is not selected");
          }
        },
      ),
    );
  }

  Widget? _buildtimingsFieldClose() {
    return Flexible(
        child: TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Add Closing Time';
        }
      },
      controller: timeinputclose, //editing controller of this TextField
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ), //icon of text field
        labelText: "Enter Closing Time",
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ), //label text of field
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          print(pickedTime.format(context)); //output 10:51 PM
          DateTime parsedTime =
              DateFormat.jm().parse(pickedTime.format(context).toString());
          //converting to DateTime so that we can further format on different pattern.
          print(parsedTime); //output 1970-01-01 22:53:00.000
          String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
          print(formattedTime); //output 14:59:00
          //DateFormat() is from intl package, you can format the time on any pattern you need.

          setState(() {
            timeinputclose.text = formattedTime; //set the value of text field.
          });
        } else {
          print("Time is not selected");
        }
      },
    ));
  }

  Widget? _buildEquipmentField() {
    return Tags(
      key: _globalKey,
      itemCount: tags.length,
      columns: 6,
      textField: TagsTextField(
          inputDecoration: InputDecoration(
            prefixIcon: Icon(
              Icons.fitness_center_rounded,
              size: 30.0,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          width: double.infinity,
          duplicates: false,
          lowerCase: true,
          autofocus: false,
          hintText: "Add Equipment",
          hintTextColor: Colors.grey,
          textStyle: TextStyle(fontSize: 14),
          onSubmitted: (string) {
            setState(() {
              tags.add(Item(title: string));
            });
          }),
      itemBuilder: (index) {
        final Item currentItem = tags[index];
        return ItemTags(
          activeColor: Colors.lightBlue[800],
          borderRadius: BorderRadius.circular(5.0),
          padding: EdgeInsets.all(10.0),
          index: index,
          title: currentItem.title,
          customData: currentItem.customData,
          textStyle: TextStyle(fontSize: 14),
          combine: ItemTagsCombine.withTextAfter,
          onPressed: (i) => print(i),
          onLongPressed: (i) => print(i),
          removeButton: ItemTagsRemoveButton(
            size: 15.0,
            onRemoved: () {
              setState(() {
                tags.removeAt(index);
              });
              return true;
            },
          ),
        );
      },
    );
  }

  Widget? MonthlyPrice() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: MonthlyController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Monthly Price Required';
          }
        },
        onSaved: (String? value) {
          fitnessCenterName = value!;
        },
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(
            Icons.attach_money_outlined,
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
          hintText: "Monthly Charges",
          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),

          //create lable
          labelText: 'Monthly Charges',
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

  Widget? LatLng() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: LatitudeController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Latitude Required';
              }
            },
            onSaved: (String? value) {
              fitnessCenterName = value!;
            },
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.grey,
              hintText: "Lat of Center",
              //make hint text
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),

              //create lable
              labelText: 'Lat of Center',
              //lable style
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: LongitudeController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Longitude Required';
              }
            },
            onSaved: (String? value) {
              fitnessCenterName = value!;
            },
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.grey,
              hintText: "Lng of Center",
              //make hint text
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),

              //create lable
              labelText: 'Lng of Center',
              //lable style
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "verdana_regular",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? CategoryField() {
    return DropDownFormField(
      required: true,
      titleText: 'Category',
      hintText: 'Please choose one',
      errorText: 'Category is Required',
      value: _myActivity,
      onSaved: (value) {
        setState(() {
          _myActivity = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _myActivity = value;
        });
      },
      dataSource: [
        {
          "display": "Gym",
          "value": "gym",
        },
        {
          "display": "Cricket Club",
          "value": "cricket club",
        },
        {
          "display": "Football Club",
          "value": "football club",
        },
        {
          "display": "Yoga Center",
          "value": "yoga center",
        },
        {
          "display": "Boxing Club",
          "value": "boxing club",
        },
        {
          "display": "Tennis",
          "value": "tennis",
        },
        {
          "display": "Karate",
          "value": "karate",
        },
        {
          "display": "Table tennis Club",
          "value": "table tennis club",
        },
        {
          "display": "BasketBall Club",
          "value": "basketball club",
        },
        {
          "display": "Swimming",
          "value": "swimming",
        },
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) => value == null ? 'Category is Required' : null,
    );
  }

// Gender Type
  Widget? Gendertype() {
    return DropDownFormField(
      required: true,
      titleText: 'Gender Allowed',
      hintText: 'Please choose one',
      errorText: 'Gender is Required',
      value: _myActivityGender,
      onSaved: (value) {
        setState(() {
          _myActivityGender = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _myActivityGender = value;
        });
      },
      dataSource: [
        {
          "display": "Male",
          "value": "male",
        },
        {
          "display": "Female",
          "value": "female",
        },
        {
          "display": "Co",
          "value": "co",
        }
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) => value == null ? 'Gender is Required' : null,
    );
  }

  Widget? CityList() {
    return DropDownFormField(
      required: true,
      titleText: 'City',
      hintText: 'Please choose one',
      errorText: 'City is Required',
      value: _myActivityCity,
      onSaved: (value) {
        setState(() {
          _myActivityCity = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _myActivityCity = value;
        });
      },
      dataSource: [
        {'display': 'Karachi', 'value': 'karachi'},
        {'display': 'Lahore', 'value': 'lahore'},
        {'display': 'Faisalabad', 'value': 'faisalabad'},
        {'display': 'Rawalpindi', 'value': 'rawalpindi'},
        {'display': 'Gujranwala', 'value': 'gujranwala'},
        {'display': 'Peshawar', 'value': 'peshawar'},
        {'display': 'Multan', 'value': 'multan'},
        {'display': 'Saidu Sharif', 'value': 'saidu sharif'},
        {'display': 'Hyderabad City', 'value': 'hyderabad city'},
        {'display': 'Islamabad', 'value': 'islamabad'},
        {'display': 'Quetta', 'value': 'quetta'},
        {'display': 'Bahawalpur', 'value': 'bahawalpur'},
        {'display': 'Sargodha', 'value': 'sargodha'},
        {'display': 'Sialkot City', 'value': 'sialkot city'},
        {'display': 'Sukkur', 'value': 'sukkur'},
        {'display': 'Larkana', 'value': 'larkana'},
        {'display': 'Chiniot', 'value': 'chiniot'},
        {'display': 'Shekhupura', 'value': 'shekhupura'},
        {'display': 'Jhang City', 'value': 'jhang city'},
        {'display': 'Dera Ghazi Khan', 'value': 'dera ghazi khan'},
        {'display': 'Gujrat', 'value': 'gujrat'},
        {'display': 'Rahimyar Khan', 'value': 'rahimyar khan'},
        {'display': 'Kasur', 'value': 'kasur'},
        {'display': 'Mardan', 'value': 'mardan'},
        {'display': 'Mingaora', 'value': 'mingaora'},
        {'display': 'Nawabshah', 'value': 'nawabshah'},
        {'display': 'Sahiwal', 'value': 'sahiwal'},
        {'display': 'Mirpur Khas', 'value': 'mirpur khas'},
        {'display': 'Okara', 'value': 'okara'},
        {'display': 'Mandi Burewala', 'value': 'mandi burewala'},
        {'display': 'Jacobabad', 'value': 'jacobabad'},
        {'display': 'Saddiqabad', 'value': 'saddiqabad'},
        {'display': 'Kohat', 'value': 'kohat'},
        {'display': 'Muridke', 'value': 'muridke'},
        {'display': 'Muzaffargarh', 'value': 'muzaffargarh'},
        {'display': 'Khanpur', 'value': 'khanpur'},
        {'display': 'Gojra', 'value': 'gojra'},
        {'display': 'Mandi Bahauddin', 'value': 'mandi bahauddin'},
        {'display': 'Abbottabad', 'value': 'abbottabad'},
        {'display': 'Turbat', 'value': 'turbat'},
        {'display': 'Dadu', 'value': 'dadu'},
        {'display': 'Bahawalnagar', 'value': 'bahawalnagar'},
        {'display': 'Khuzdar', 'value': 'khuzdar'},
        {'display': 'Pakpattan', 'value': 'pakpattan'},
        {'display': 'Tando Allahyar', 'value': 'tando allahyar'},
        {'display': 'Ahmadpur East', 'value': 'ahmadpur east'},
        {'display': 'Vihari', 'value': 'vihari'},
        {'display': 'Jaranwala', 'value': 'jaranwala'},
        {'display': 'New Mirpur', 'value': 'new mirpur'},
        {'display': 'Kamalia', 'value': 'kamalia'},
        {'display': 'Kot Addu', 'value': 'kot addu'},
        {'display': 'Nowshera', 'value': 'nowshera'},
        {'display': 'Swabi', 'value': 'swabi'},
        {'display': 'Khushab', 'value': 'khushab'},
        {'display': 'Dera Ismail Khan', 'value': 'dera ismail khan'},
        {'display': 'Chaman', 'value': 'chaman'},
        {'display': 'Charsadda', 'value': 'charsadda'},
        {'display': 'Kandhkot', 'value': 'kandhkot'},
        {'display': 'Chishtian', 'value': 'chishtian'},
        {'display': 'Hasilpur', 'value': 'hasilpur'},
        {'display': 'Attock Khurd', 'value': 'attock khurd'},
        {'display': 'Muzaffarabad', 'value': 'muzaffarabad'},
        {'display': 'Mianwali', 'value': 'mianwali'},
        {'display': 'Jalalpur Jattan', 'value': 'jalalpur jattan'},
        {'display': 'Bhakkar', 'value': 'bhakkar'},
        {'display': 'Zhob', 'value': 'zhob'},
        {'display': 'Dipalpur', 'value': 'dipalpur'},
        {'display': 'Kharian', 'value': 'kharian'},
        {'display': 'Mian Channun', 'value': 'mian channun'},
        {'display': 'Bhalwal', 'value': 'bhalwal'},
        {'display': 'Jamshoro', 'value': 'jamshoro'},
        {'display': 'Pattoki', 'value': 'pattoki'},
        {'display': 'Harunabad', 'value': 'harunabad'},
        {'display': 'Kahror Pakka', 'value': 'kahror pakka'},
        {'display': 'Toba Tek Singh', 'value': 'toba tek singh'},
        {'display': 'Samundri', 'value': 'samundri'},
        {'display': 'Shakargarh', 'value': 'shakargarh'},
        {'display': 'Sambrial', 'value': 'sambrial'},
        {'display': 'Shujaabad', 'value': 'shujaabad'},
        {'display': 'Hujra Shah Muqim', 'value': 'hujra shah muqim'},
        {'display': 'Kabirwala', 'value': 'kabirwala'},
        {'display': 'Mansehra', 'value': 'mansehra'},
        {'display': 'Lala Musa', 'value': 'lala musa'},
        {'display': 'Chunian', 'value': 'chunian'},
        {'display': 'Nankana Sahib', 'value': 'nankana sahib'},
        {'display': 'Bannu', 'value': 'bannu'},
        {'display': 'Pasrur', 'value': 'pasrur'},
        {'display': 'Timargara', 'value': 'timargara'},
        {'display': 'Parachinar', 'value': 'parachinar'},
        {'display': 'Chenab Nagar', 'value': 'chenab nagar'},
        {'display': 'Gwadar', 'value': 'gwadar'},
        {'display': 'Abdul Hakim', 'value': 'abdul hakim'},
        {'display': 'Hassan Abdal', 'value': 'hassan abdal'},
        {'display': 'Tank', 'value': 'tank'},
        {'display': 'Hangu', 'value': 'hangu'},
        {'display': 'Risalpur Cantonment', 'value': 'risalpur cantonment'},
        {'display': 'Karak', 'value': 'karak'},
        {'display': 'Kundian', 'value': 'kundian'},
        {'display': 'Umarkot', 'value': 'umarkot'},
        {'display': 'Chitral', 'value': 'chitral'},
        {'display': 'Dainyor', 'value': 'dainyor'},
        {'display': 'Kulachi', 'value': 'kulachi'},
        {'display': 'Kalat', 'value': 'kalat'},
        {'display': 'Kotli', 'value': 'kotli'},
        {'display': 'Gilgit', 'value': 'gilgit'},
        {'display': 'Narowal', 'value': 'narowal'},
        {'display': 'Khairpur Mir"s', 'value': 'khairpur mir"s'},
        {'display': 'Khanewal', 'value': 'khanewal'},
        {'display': 'Jhelum', 'value': 'jhelum'},
        {'display': 'Haripur', 'value': 'haripur'},
        {'display': 'Shikarpur', 'value': 'shikarpur'},
        {'display': 'Rawala Kot', 'value': 'rawala kot'},
        {'display': 'Hafizabad', 'value': 'hafizabad'},
        {'display': 'Lodhran', 'value': 'lodhran'},
        {'display': 'Malakand', 'value': 'malakand'},
        {'display': 'Attock City', 'value': 'attock city'},
        {'display': 'Batgram', 'value': 'batgram'},
        {'display': 'Matiari', 'value': 'matiari'},
        {'display': 'Ghotki', 'value': 'ghotki'},
        {'display': 'Naushahro Firoz', 'value': 'naushahro firoz'},
        {'display': 'Alpurai', 'value': 'alpurai'},
        {'display': 'Bagh', 'value': 'bagh'},
        {'display': 'Daggar', 'value': 'daggar'},
        {'display': 'Leiah', 'value': 'leiah'},
        {'display': 'Tando Muhammad Khan', 'value': 'tando muhammad khan'},
        {'display': 'Chakwal', 'value': 'chakwal'},
        {'display': 'Badin', 'value': 'badin'},
        {'display': 'Lakki', 'value': 'lakki'},
        {'display': 'Rajanpur', 'value': 'rajanpur'},
        {'display': 'Dera Allahyar', 'value': 'dera allahyar'},
        {'display': 'Shahdad Kot', 'value': 'shahdad kot'},
        {'display': 'Pishin', 'value': 'pishin'},
        {'display': 'Sanghar', 'value': 'sanghar'},
        {'display': 'Upper Dir', 'value': 'upper dir'},
        {'display': 'Thatta', 'value': 'thatta'},
        {'display': 'Dera Murad Jamali', 'value': 'dera murad jamali'},
        {'display': 'Kohlu', 'value': 'kohlu'},
        {'display': 'Mastung', 'value': 'mastung'},
        {'display': 'Dasu', 'value': 'dasu'},
        {'display': 'Athmuqam', 'value': 'athmuqam'},
        {'display': 'Loralai', 'value': 'loralai'},
        {'display': 'Barkhan', 'value': 'barkhan'},
        {'display': 'Musa Khel Bazar', 'value': 'musa khel bazar'},
        {'display': 'Ziarat', 'value': 'ziarat'},
        {'display': 'Gandava', 'value': 'gandava'},
        {'display': 'Sibi', 'value': 'sibi'},
        {'display': 'Dera Bugti', 'value': 'dera bugti'},
        {'display': 'Eidgah', 'value': 'eidgah'},
        {'display': 'Uthal', 'value': 'uthal'},
        {'display': 'Khuzdar', 'value': 'khuzdar'},
        {'display': 'Chilas', 'value': 'chilas'},
        {'display': 'Panjgur', 'value': 'panjgur'},
        {'display': 'Gakuch', 'value': 'gakuch'},
        {'display': 'Qila Saifullah', 'value': 'qila saifullah'},
        {'display': 'Kharan', 'value': 'kharan'},
        {'display': 'Aliabad', 'value': 'aliabad'},
        {'display': 'Awaran', 'value': 'awaran'},
        {'display': 'Dalbandin', 'value': 'dalbandin'}
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) => value == null ? 'City is Required' : null,
    );
  }

  Widget? ImgPickerFunction() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          //open button ----------------
          ElevatedButton.icon(
            onPressed: () {
              openImages();
            },
            label: Text(
              "Add Images",
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.image_outlined,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              primary: Colors.lightBlue[800],
            ),
          ),

          Divider(),
          Text("Selected Images:"),
          Divider(),

          imagefiles != null
              ? Wrap(
                  children: imagefiles!.map((imageone) {
                    return Container(
                        child: Card(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    ));
                  }).toList(),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SingleChildScrollView(
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
                        child: _buildNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildCenterNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildAddressField(),
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
                        child: CategoryField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Gendertype(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CityList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MonthlyPrice(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildEquipmentField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildtimingsField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildtimingsFieldClose(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LatLng(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ImgPickerFunction(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        width: double.infinity,
                        child: FlatButton(
                          color: Colors.lightBlue[800],
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: const Text('Save',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          onPressed: () {
                            if (!_formkey.currentState!.validate()) {
                              AlertDialog(
                                title: Text('Fill All Info!'),
                              );
                              return;
                            }
                            AlertDialog(
                              title: Text('Form data save'),
                            );
                            registerUser();

                            FormInformationStored();
                            Navigator?.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeGymOwner()));
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

  Future registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount? gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await gymOwnerReference.doc(gCurrentUser?.id).get();
    List EquipmentsNames = [];
    for (var element in tags) {
      EquipmentsNames.add(element.title);
    }
    List ImageUrls = [];
    var count = 0;

    for (var element in imagefiles!) {
      var counttostring = count.toString();
      UploadTask mStorageUploadTask = storageReference
          .child("post_${postId + counttostring}.jpg")
          .putFile(File(element.path));
      count = count + 1;
      TaskSnapshot storageTaskSnapshot = await mStorageUploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      ImageUrls.add(downloadUrl);
    }

    gymOwnerReference
        .doc(gSignIn.currentUser?.id)
        .collection("FitnessCenterDetails")
        .doc(gSignIn.currentUser?.id)
        .set({
      'name': OwnernameController.text,
      'centername': CenternameController.text,
      'address': AddressController.text,
      'email': EmailController.text,
      'phone': PhoneController.text,
      'opentime': timeinputopen.text,
      'closetime': timeinputclose.text,
      'equipment': EquipmentsNames,
      'MonthFee': MonthlyController.text,
      'City': _myActivityCity,
      'Category': _myActivity,
      'Gender': _myActivityGender,
      'Approved': false,
      'Lat': LatitudeController.text,
      'Lng': LongitudeController.text,
      'Images': ImageUrls
    });
  }

  FormInformationStored() async {
    FirebaseFirestore.instance
        .collection('gymOwner')
        .doc(gSignIn.currentUser?.id)
        .update({"formRegister": "exists"});
  }
}
