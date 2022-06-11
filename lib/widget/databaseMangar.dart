import 'package:cloud_firestore/cloud_firestore.dart';

Future getUser() async{
  List itemsList = [];
  try{
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        itemsList.add(element.data());
      });
    });
    return itemsList;
  }catch(e){
    return e;
  }
}