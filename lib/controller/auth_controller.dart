import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/model/user_model.dart';

class AuthController {
  static String? userToken;
  static UserModel? userData;

  static Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);
    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));

    userToken = token;
    userData = model;
  }

  static Future updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));
    userData = model;
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    if (token != null) {
      userToken = token;
    }
    String? data = sharedPreferences.getString("user_data");

    if (data != null) {
      userData = UserModel.fromJson(jsonDecode(data));
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString("token");

    return token != null;
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
