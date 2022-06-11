import 'dart:math';
import 'dart:ui';

import 'package:beauty/screen/gust_screen.dart';
import 'package:beauty/screen/home_screen.dart';
import 'package:beauty/screen/provider_screen.dart';
import 'package:beauty/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_text_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final List<String> typeItems = [
    'Make up',
    'Model',
    'hair',
  ];
  String? selectedValue;


  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController region = TextEditingController();


  void _saveUser(){
    FirebaseFirestore.instance.collection('Users').add({
      'name':name.text,
      'phone':phone.text,
      'region':region.text,
      'type':selectedValue,
      'id':Random().nextInt(100000)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Center(child: Image(image: const AssetImage('assets/beauty.jpeg'),width: 300.w,)),
                    CustomTextWidget(
                      title: 'SIGN UP',
                      color: Colors.black54,
                      size: 40.sp,
                    ),
                    const SizedBox(height: 20,),
                    text(name,'please enter the username', 'Provider Name', const Icon(Icons.person,color: Colors.pinkAccent)),
                    const SizedBox(height: 20,),
                    text(phone,'please enter the Mobile Number', 'Mobile Number', const Icon(Icons.mobile_friendly,color: Colors.pinkAccent)),
                    const SizedBox(height: 20,),
                    text(region,'please enter the Region', 'Region', const Icon(Icons.location_on,color: Colors.pinkAccent)),
                    const SizedBox(height: 20,),
                    Container(
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          fillColor: Colors.black12,
                          filled: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0.w),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        hint:  Text(
                          'Select Your Type',
                          style: TextStyle(fontSize: 15.sp,color: Colors.black87),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.pinkAccent,
                        ),
                        iconSize: 40,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: typeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Type.';
                          }
                        },
                        onChanged: (value) {
                          selectedValue = value.toString();
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            print(phone.text);
                            print(name.text);
                            print(region.text);
                            print(selectedValue);
                            _saveUser();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('login', phone.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProviderScreen()),
                            );
                            print('suc');
                          }else{
                            print('error');
                          }
                        },
                        child: Column(
                          children:const [
                            Text('Sign Up',style: TextStyle(color: Colors.white),),
                          ],
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  Widget text(TextEditingController controller,String msg,String text,Icon icon){
    return Container(

      child: TextFormField(
        controller: controller,
        validator: (value){
          if(value!.isEmpty){
            return '$msg';
          }
          return null;
        },
        decoration:  InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
            hintText: '$text',
            prefixIcon:  icon,
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
            fillColor: Colors.black12,
            filled: true,
            hintStyle: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
