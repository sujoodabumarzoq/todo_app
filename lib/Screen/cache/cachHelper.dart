
import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
 late SharedPreferences sharedPreferences ;
Future<void> CacheInitialization () async {

  sharedPreferences =await SharedPreferences.getInstance();
///methods
  ///1.set data
Future<String> setData({required String key, required String value }) async {

if(value is String ){
  await sharedPreferences.setString(key, value);
return "ture";
}

return "false";



}

}

}