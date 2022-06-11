import 'dart:ui';

import 'package:beauty/screen/search_screen.dart';
import 'package:beauty/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/custom_text_widget.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        automaticallyImplyLeading: false,
        title: CustomTextWidget(
          title: 'Provider',
          size: 25.sp,
          color: Colors.white,
        ),
        actions:  [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 7.w),
            child:  IconButton(icon: Icon(Icons.search,size: 32.sp,),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
            },),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsetsDirectional.all(20),
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 23.0,
              childAspectRatio: 1/1.4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  10,
                      (index) =>  GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                        },
                        child: Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Image(
                           image:   AssetImage('assets/splash_img.jpg'),
                              ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                 Text(
                                  'somaya makeup',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      height: 1.1,
                                      fontSize: 14.0
                                  ),
                                ),
                                 SizedBox(height: 4,),
                                 Text(
                                  'makeup',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      height: 1.1,
                                      fontSize: 14.0
                                  ),
                                ),
                                 SizedBox(height: 4,),
                                 Text(
                                  '222',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      height: 1.1,
                                      fontSize: 14.0
                                  ),
                                ),
                                 SizedBox(height: 4,),
                                 Text(
                                  'saudia-arabia',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      height: 1.1,
                                      fontSize: 14.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                    ),
                  ),
                      ))
          ),
        ),
      )
      ,
    );
  }

}
