import 'package:beauty/screen/gust_screen.dart';
import 'package:beauty/screen/provider_screen.dart';
import 'package:beauty/screen/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffe70bd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              autofocus: true,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white70,
                  onPrimary: Colors.pinkAccent,
                  side: BorderSide(
                      width: 0.5.w,
                      color: Colors.white,
                      style: BorderStyle.solid),
                  padding:
                      EdgeInsets.symmetric(horizontal: 70.h, vertical: 15.w),
                  textStyle: TextStyle(fontSize: 20.sp)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('guest', 'guest');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProviderScreen()));
              },
              child: const Text(
                'guest',
                style: TextStyle(color: Colors.black87),
              )),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
              autofocus: true,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white38,
                  onPrimary: Colors.pinkAccent,
                  side: BorderSide(
                      width: 0.5.w,
                      color: Colors.white,
                      style: BorderStyle.solid),
                  padding:
                      EdgeInsets.symmetric(horizontal: 58.h, vertical: 15.w),
                  textStyle: TextStyle(fontSize: 20.sp, color: Colors.black87)),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: const Text('Do you have an account?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text('login'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen())),
                        child: const Text('register'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'provider',
                style: TextStyle(color: Colors.black87),
              )),
        ],
      ),
    );
  }
}
