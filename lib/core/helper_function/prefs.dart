import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future startSharedPref()async{
  sharedPreferences = await SharedPreferences.getInstance();
}