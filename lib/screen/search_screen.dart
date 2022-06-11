import 'package:beauty/screen/search_result_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/custom_text_widget.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataList();
  }

  TextEditingController name_provider = TextEditingController();
  TextEditingController location_provider = TextEditingController();
  TextEditingController type_provider = TextEditingController();


  List userRegister = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  getData() async{
    List itemsList = [];
    try{
      await FirebaseFirestore.instance.collection('Users')
          .where('name',isEqualTo:name_provider.text)
          .where('region',isEqualTo:location_provider.text)
          .where('type',isEqualTo:type_provider.text)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    }catch(e){
      return e;
    }
  }
  fetchDataList() async{

    dynamic result = await getData();
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
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: CustomTextWidget(
          title: 'Search',
          color: Colors.white,
          size: 20.sp,
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               SizedBox(height: 20.h,),
              text(name_provider,'name the provider'),
               SizedBox(height: 10.h,),
              text(location_provider,'location the provider'),
               SizedBox(height: 10.h,),
              text(type_provider,'type the provider'),
              SizedBox(height: 10.h,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(
                  onPressed: (){
                     fetchDataList();
                      print(name_provider.text);
                      print(location_provider.text);
                      print(type_provider.text);
                      print(userRegister);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SearchResultScreen(userRegister:userRegister)),
                      );
                    },
                  child: Column(
                    children: [
                      Text('Search',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                    ],
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget text(TextEditingController controller,String text){
    return Container(
      child: TextFormField(
        controller: controller,
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
              color: Colors.black38,
              width: 1.0,
            ),
          ),
          hintText: '$text',
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

}
