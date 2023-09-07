import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quotez/Models/random_quote_model.dart';
import 'package:quotez/Services/database_helper.dart';
import '../Models/saved_item_model.dart';
import '../Services/api_service.dart';
class HomePageController extends GetxController{
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    getCategories();
    getFilteredData();
fetchDataFromDatabase();
    super.onInit();

  }
  final DatabaseHelper dbHelper = DatabaseHelper();

  final tabsData = <String>[].obs;
  var isLoading=false.obs;
  var selectedCategory = ''.obs;
  var dataList = <String>[].obs; // Replace 'String' with your data model type

  Future<void> getCategories() async {
    try {
  var apiKey = dotenv.env['API_KEY'];
  // final accessToken=prefs.getString("accessToken");
  // subCategoryList.clear();
  tabsData.clear();
  var headers = {
  "content-type": "application/json",
  'X-RapidAPI-Key': "$apiKey",
  'X-RapidAPI-Host': 'famous-quotes4.p.rapidapi.com',
  };
      String? url =
          "https://famous-quotes4.p.rapidapi.com/";
      // var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.categoriesEndPoints.categories);
      print("call Url -> :: $url");
      // print("token -> ::$accessToken");
  final data = await _apiService.get(url, headers: headers);

        print("cat $data");
        for(var i in data){
          tabsData.add(i);
        }
  adFalse();
  print("list: $tabsData");
      }
  catch (e) {
  // Handle the exception (e.g., show an error dialog, display a message)
  print(e);
  }

    }


  var randomQuoteList=<RandomQuoteModel>[].obs;
  var savedItemsList = <RandomQuoteModel>[].obs;

  Future<void> getQuoteFromCategory(String cat) async {
    try {
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
    String? url =
        "https://famous-quotes4.p.rapidapi.com/random?category=$cat&count=10";
      // var url=Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.categoriesEndPoints.categories);
      print("call Url -> :: $url");
      // print("token -> ::$accessToken");
    final data = await _apiService.get(url, headers: headers);

        isLoading.value=false;
        print("data $data");
       if(data is Iterable){
         for(var i in data){
           randomQuoteList.add(RandomQuoteModel.fromJson(i));
         }
       }

        print("my data: ${randomQuoteList.length}");

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
      isLoading.value=true;
    }
  }
var selectedChip=false.obs;
List<bool> selectedFalse=[];
void adFalse(){
  selectedFalse = List.filled(tabsData.length, false, growable: true);
  print("selected:$selectedFalse");
}

  void setCategory(String category) {
    selectedCategory.value = category;
  }


  void getFilteredData() {
    if (selectedCategory.isEmpty) {
      getQuoteFromCategory("all");
    } else {
       getQuoteFromCategory(selectedCategory.value);
    }
  }

  void saveItemToDatabase(RandomQuoteModel item) async {
    Item databaseItem = Item(text: item.text!, author:item.author!,category: item.category!);
    await dbHelper.insertItem(databaseItem);
    fetchDataFromDatabase(); // Refresh the list after saving
  }
  void removeItemFromDatabase(String item) async {
    await dbHelper.removeItem(item);
    fetchDataFromDatabase(); // Refresh the saved items list after removal
  }

  Future<void> fetchDataFromDatabase() async {
  print("somethinhg");
    List<Item> databaseItems = await dbHelper.getItems();
    print('Number of Items in Database: ${databaseItems.length}');
    List<RandomQuoteModel> savedItems = databaseItems.map((item) {
      return RandomQuoteModel(text: item.text, author: item.author, category: item.category); // Replace 'Some Category' with the actual category
    }).toList();

    savedItemsList.assignAll(savedItems);
  }










}