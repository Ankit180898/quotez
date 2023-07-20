import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quotez/Models/random_quote_model.dart';
class HomePageController extends GetxController{
  @override
  void onInit() {
    getCategories();
    getQuoteFromCategory();
    super.onInit();

  }

  final tabsData = <String>[].obs;
  var isLoading=false.obs;

  // var subCategoryList = <SubCategoryModel>[].obs;

  Future<void> getCategories() async {
    var apiKey = dotenv.env['API_KEY'];
    // final accessToken=prefs.getString("accessToken");
    // subCategoryList.clear();
    var headers = {
      "content-type": "application/json",
      'X-RapidAPI-Key': "$apiKey",
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
        print("cat $json");
        for(var i in json){
          tabsData.add(i);
        }
        print("list: $tabsData");
      }
      else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      // refreshToken();

    }
  }

  var randomQuoteList=<RandomQuoteModel>[].obs;
  Future<void> getQuoteFromCategory() async {
    var apiKey = dotenv.env['API_KEY'];
    // final accessToken=prefs.getString("accessToken");
    // subCategoryList.clear();
    isLoading.value=true;
    randomQuoteList.clear();
    var headers = {
      "content-type": "application/json",
      'X-RapidAPI-Key': "$apiKey",
      'X-RapidAPI-Host': "famous-quotes4.p.rapidapi.com",
    };
    try {
      var url = Uri.parse(
          "https://famous-quotes4.p.rapidapi.com/random?category=all&count=10");
      // var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.categoriesEndPoints.categories);
      print("call Url -> :: $url");
      // print("token -> ::$accessToken");
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        isLoading.value=false;
        final json = jsonDecode(response.body);
        print("data $json");
       if(json is Iterable){
         for(var i in json){
           randomQuoteList.add(RandomQuoteModel.fromJson(i));
         }
       }
        print("my data: ${randomQuoteList.length}");

      }else {
        throw "Unknown Error Occurred";
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