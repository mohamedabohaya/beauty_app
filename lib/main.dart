import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:beauty/screen/home_screen.dart';
import 'package:beauty/screen/provider_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? login = false;
  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('login') != null){
      login = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 887),
    builder: (BuildContext c) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: double.maxFinite,
          splash: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Image(image: const AssetImage('assets/beauty.jpeg'),width: 300.w,),
              SizedBox(height: 30.h,),
            ],
          ),
          nextScreen: login == true ? const ProviderScreen() : const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: const Color(0xffffffff)
      ),
    ));
  }
}

