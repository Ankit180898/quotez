import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class HomePageController extends GetxController{
  @override
  void onInit() {
    super.onInit();
getCategories();
  }

  // var subCategoryList = <SubCategoryModel>[].obs;

  Future<void> getCategories() async {
    print("im here");

    // final accessToken=prefs.getString("accessToken");
    // subCategoryList.clear();
    var headers = {
      'X-RapidAPI-Key': '54d575a476msh09df92c970ae266p1c0a2bjsn2b47f9261054',
      'X-RapidAPI-Host': 'famous-quotes4.p.rapidapi.com',
    };
    try {
      var url = Uri.parse(
          "https://famous-quotes4.p.rapidapi.com/");
      // var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.categoriesEndPoints.categories);
      print("call Url -> :: $url");
      // print("token -> ::$accessToken");
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print("data $json");
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      // refreshToken();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error"),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }


}