import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';


Future<bool> savePrefString({String? key, dynamic value})async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove(key!);
  return preferences.setString(key, value);
}
Future<String?> getPrefString({String? key})async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? value= preferences.getString(key!);
  return value;
}
Future<bool> savePrefBool({String? key, dynamic value})async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove(key!);
  return preferences.setBool(key, value);
}
Future<bool> getPrefBool({String? key})async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool value= preferences.getBool(key!)??false;
  return value;
}
Future<bool> removeData({String? key})async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.remove(key!);
}


class Shared{
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  // static Future<bool>? setBool({@required String? key,@required bool? value}) async {
  //   return await sharedPreferences!.setBool(key!, value!);
  // }

  static Future<bool> setData({@required String? key,@required dynamic value}) async {
    if(value is String) return await sharedPreferences!.setString(key!, value);
    if(value is int) return await sharedPreferences!.setInt(key!, value);
    if(value is bool) return await sharedPreferences!.setBool(key!, value);

     return await sharedPreferences!.setDouble(key!, value);
  }

  static dynamic getData({@required dynamic key}) {
    return sharedPreferences!.get(key);
  }
}