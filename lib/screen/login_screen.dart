import 'dart:ui';

import 'package:beauty/screen/home_screen.dart';
import 'package:beauty/screen/provider_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared.dart';
import '../widget/custom_text_widget.dart';
import '../widget/databaseMangar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  TextEditingController phone = TextEditingController();
  List userRegister = [];
  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataList();
  }

  fetchDataList() async{
    dynamic result = await getUser();
    if(result == null){
      print('unable to get data');
    }else{
      setState(() {
        userRegister = result;
      });
    }
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
                      title: 'Login',
                      color: Colors.black54,
                      size: 40.sp,
                    ),
                    const SizedBox(height: 20,),
                    text(phone,'please enter the Mobile Number', 'Mobile Number', const Icon(Icons.mobile_friendly,color: Colors.pinkAccent)),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          var user_phone = '';
                          if(formKey.currentState!.validate()){
                            print(userRegister);
                            for (int i = 0; i<userRegister.length;i++){
                              if(phone.text == userRegister[i]['phone']){
                                  user_phone = userRegister[i]['phone'];
                              }
                            }
                            if(phone.text == user_phone){
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('login', phone.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProviderScreen()),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.pinkAccent,
                                    content: const Text('the phone dose not exit !'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  )
                              );
                            }
                          }
                        },
                        child: Column(
                          children:const [
                            Text('Login',style: TextStyle(color: Colors.white),),
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
