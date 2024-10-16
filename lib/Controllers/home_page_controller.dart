import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quotez/Models/random_quote_model.dart';
import 'package:quotez/Services/database_helper.dart';
import '../Models/saved_item_model.dart';
import '../Services/api_service.dart';

class HomePageController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final DatabaseHelper dbHelper = DatabaseHelper();

  final tabsData = <String>[].obs;
  var isLoading = false.obs;
  var selectedCategory = Rx<String?>(null);
  var randomQuoteList = <RandomQuoteModel>[].obs;
  var savedItemsList = <RandomQuoteModel>[].obs;
  var filteredQuotes = <RandomQuoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getFilteredData();
    fetchDataFromDatabase();
  }

  Future<void> getCategories() async {
    try {
      var apiKey = dotenv.env['API_KEY'];
      tabsData.clear();
      var headers = {
        "content-type": "application/json",
        'X-RapidAPI-Key': "$apiKey",
        'X-RapidAPI-Host': 'famous-quotes4.p.rapidapi.com',
      };
      String? url = "https://famous-quotes4.p.rapidapi.com/";
      final data = await _apiService.get(url, headers: headers);

      for (var i in data) {
        tabsData.add(i);
      }
      adFalse();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getQuoteFromCategory(String cat) async {
    try {
      var apiKey = dotenv.env['API_KEY'];
      isLoading.value = true;
      randomQuoteList.clear();
      var headers = {
        "content-type": "application/json",
        'X-RapidAPI-Key': "$apiKey",
        'X-RapidAPI-Host': "famous-quotes4.p.rapidapi.com",
      };
      String? url = "https://famous-quotes4.p.rapidapi.com/random?category=$cat&count=10";
      final data = await _apiService.get(url, headers: headers);

      isLoading.value = false;
      if (data is Iterable) {
        for (var i in data) {
          randomQuoteList.add(RandomQuoteModel.fromJson(i));
        }
      }
      filteredQuotes.assignAll(randomQuoteList);
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Error"),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
      isLoading.value = false;
    }
  }

  var selectedChip = false.obs;
  List<bool> selectedFalse = [];
  void adFalse() {
    selectedFalse = List.filled(tabsData.length, false, growable: true);
  }

  void toggleCategory(String category) {
    if (selectedCategory.value == category) {
      // Deselect if the same category is clicked again
      selectedCategory.value = null;
      getQuoteFromCategory("all"); // Fetch quotes for all categories
    } else {
      // Select the new category
      selectedCategory.value = category;
      getQuoteFromCategory(category);
    }
  }

  void getFilteredData() {
    if (selectedCategory.value == null || selectedCategory.value!.isEmpty) {
      getQuoteFromCategory("all");
    } else {
      getQuoteFromCategory(selectedCategory.value!);
    }
  }

  void saveItemToDatabase(RandomQuoteModel item) async {
    Item databaseItem = Item(text: item.text!, author: item.author!, category: item.category!);
    await dbHelper.insertItem(databaseItem);
    fetchDataFromDatabase();
  }

  void removeItemFromDatabase(String item) async {
    await dbHelper.removeItem(item);
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    List<Item> databaseItems = await dbHelper.getItems();
    List<RandomQuoteModel> savedItems = databaseItems.map((item) {
      return RandomQuoteModel(text: item.text, author: item.author, category: item.category);
    }).toList();

    savedItemsList.assignAll(savedItems);
  }

  void filterQuotes(String query) {
    if (query.isEmpty) {
      filteredQuotes.assignAll(randomQuoteList);
    } else {
      filteredQuotes.assignAll(randomQuoteList.where((quote) =>
          quote.text!.toLowerCase().contains(query.toLowerCase()) ||
          quote.author!.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void searchQuery(String query) {
    if (query.isEmpty) {
      tabsData.assignAll(tabsData);
    } else {
      var filteredCat = tabsData
          .where((category) =>
          category.toLowerCase().contains(query.toLowerCase()))
          .toList();
      tabsData.assignAll(filteredCat);
    }
  }

  bool isCategorySelected(String category) {
    return selectedCategory.value == category;
  }
}
