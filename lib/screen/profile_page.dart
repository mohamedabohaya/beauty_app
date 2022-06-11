import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/custom_text_widget.dart';
import '../widget/databaseMangar.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  int? id;

  ProfilePage({Key? key, this.id,}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
    fetchDataList();
  }

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image != null) return;
      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch(e){
      print('Faild : $e');
    }

    }
  Future<String> uploadFile(File image) async
  {
    String downloadURL;
    String postId=DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("images").child("$postId");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
  // uploadToFirebase()async
  // {
  //   String url=await uploadFile(image!); // this will upload the file and store url in the variable 'url'
  //   await FirebaseFirestore.instance.collection('Images').doc(widget.id).update({  //use update to update the doc fields.
  //     'url':url
  //   });
  // }

  void _saveImage(){
      FirebaseFirestore.instance.collection('Images').add({
        'id': widget.id,
        'image': image,
      });
    }

  List userRegister = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  getData() async{
    List itemsList = [];
    try{
      await FirebaseFirestore.instance.collection('Users').where('id',isEqualTo:widget.id).get().then((value) {
        value.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      print(itemsList);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: CustomTextWidget(
          title: userRegister.isEmpty ? "": userRegister[0]['name'],
          color: Colors.white,
          size: 25.sp,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.only(start: 22.w,end: 22.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 24.h),
            ProfileWidget(
              imagePath: 'assets/beauty.jpeg',
              onClicked: () async {},
            ),
            SizedBox(height: 24.h),
            CustomTextWidget(
              title: 'about',
              fontWeight: FontWeight.w300,
              size: 35.sp,
            ),
            SizedBox(height: 5.h),
            CustomTextWidget(
              title: 'dnqwifnqwuifnqwiufnwiufnwuifnsiufnv qsidfnqsifnqeiufn ewfinewifnweiun weg weijfnwe ifnwe',
              fontWeight: FontWeight.w200,
              size: 20.sp,
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                CustomTextWidget(
                  title: 'Images',
                  fontWeight: FontWeight.w300,
                  size: 35.sp,
                ),
                const Spacer(),
                IconButton(
                    onPressed: (){
                      print(widget.id);
                      print(userRegister);
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Add new photo '),
                            content: GestureDetector(
                              onTap: (){
                              pickImage();
                            },
                                child : image == null ? CustomTextWidget(
                                  title: 'click here to add !',
                                  color: Colors.blueAccent,
                                ) : Image.file(image!),
                            ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel'),
                          ),TextButton(
                            onPressed: () {
                              _saveImage();
                              Navigator.pop(context);
                            },
                            child: const Text('save'),
                          ),
                        ],
                      ));
                     },
                    icon: const Icon(Icons.camera_alt_outlined,color: Colors.black45,))
              ],
            ),
            SizedBox(height: 10.h),
            GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2.0 / 2.4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    8,
                        (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ProfilePage()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image(
                              image: const AssetImage('assets/beauty.jpeg'),width:150.w,height: 150.h,
                            ),
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }




}


