import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static late  SharedPreferences sharedPreference;
  static init() async {
    sharedPreference= await SharedPreferences.getInstance();
  }
  static Future<bool>  putMode({
  required String key,
   required bool value,
}) async{
   return await sharedPreference.setBool(key, value);
  }
  static  bool? getMode({
    required String key,
  }) {
    return sharedPreference.getBool(key);
  }
}