import 'package:beauty/screen/profile_page.dart';
import 'package:beauty/screen/provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/custom_text_widget.dart';

class SearchResultScreen extends StatefulWidget {
  List userRegister;
  SearchResultScreen({
    required this.userRegister,
  });



  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1e6eb),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: CustomTextWidget(
          title: 'Search Result',
          color: Colors.white,
          size: 20.sp,
        ),
      ),
      body: order(),
    );
  }

  Widget order(){
    return  SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.userRegister.length,
              itemBuilder: (BuildContext context, int index) {
                if(widget.userRegister.isNotEmpty){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ProfilePage(id:widget.userRegister[index]['id'])));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 30.w, end: 30.w, bottom: 20.h),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children:  [
                                    Image(
                                      image: const AssetImage('assets/beauty.jpeg',),
                                      width: 150.w,
                                      height: 150.h,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding:  EdgeInsetsDirectional.only(end: 30.0.h),
                                  child: Column(
                                    children: [
                                      CustomTextWidget(
                                        title: widget.userRegister[index]['name'],
                                        color: Colors.black38,
                                      ),
                                      CustomTextWidget(
                                        paddingTop: 5.h,
                                        title: widget.userRegister[index]['region'],
                                        color: Colors.black38,
                                      ),
                                      CustomTextWidget(
                                        paddingTop: 5.h,
                                        title: widget.userRegister[index]['type'],
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return const Center(child:  Text('No Data'));
                }
              })
        ],
      ),
    );
  }
}
