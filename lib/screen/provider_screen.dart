import 'package:beauty/screen/home_screen.dart';
import 'package:beauty/screen/profile_page.dart';
import 'package:beauty/screen/search_screen.dart';
import 'package:beauty/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_text_widget.dart';
import '../widget/databaseMangar.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen>  {
  List userRegister = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
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
    fetchDataList();
    print(userRegister);
    checkLogin();
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
      backgroundColor: const Color(0xffe1e6eb),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        automaticallyImplyLeading: true,
        title: CustomTextWidget(
          title: 'Provider',
          size: 25.sp,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 7.w),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 32.sp,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
            ),
          )
        ],
      ),
      drawer:  login == true ?
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CircleAvatar(
                    backgroundImage:const AssetImage('assets/splash_img.jpg',),
                    maxRadius: 50.w,
                  ),
                  SizedBox(height: 10.h,),
                   Text(
                    'Mohamed Abohaya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: ()  {

              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('login');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
            ),
          ],
        ),
      ) : null,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsetsDirectional.all(20),
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  userRegister.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ProfilePage(id:userRegister[index]['id'])));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Center(
                                 child: Image(
                                  image: const AssetImage('assets/beauty.jpeg'),width:150.w,height: 150.h,
                              ),
                               ),
                               Divider(
                                height: 0.5.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      "Name : ${userRegister[index]['name']}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          height: 1.1, fontSize: 14.0),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                     Text(
                                      "Type : ${userRegister[index]['type']}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          height: 1.1, fontSize: 14.0),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                     Text(
                                       "Location : ${userRegister[index]['region']}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          height: 1.1, fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
        ),
      ),
    );
  }
}
