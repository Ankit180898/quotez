import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Models/random_quote_model.dart';
import 'package:quotez/Views/quote_display_screen.dart';
import '../Controllers/theme_controller.dart';
// import this


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageController controller = Get.put(HomePageController());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quotez",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(),
          Expanded(child: _buildQuotesList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: controller.filterQuotes,
        decoration: InputDecoration(
          hintText: 'Search quotes...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.tabsData.length,
        itemBuilder: (context, index) {
          final category = controller.tabsData[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Obx(() => ChoiceChip(
              label: Text(category),
              selected: controller.isCategorySelected(category),
              onSelected: (selected) {
                controller.toggleCategory(category);
              },
            )),
          );
        },
      )),
    );
  }

  Widget _buildQuotesList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.filteredQuotes.isEmpty) {
        return const Center(child: Text('No quotes found'));
      }
      return ListView.builder(
        itemCount: controller.filteredQuotes.length,
        itemBuilder: (context, index) {
          final RandomQuoteModel quote = controller.filteredQuotes[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double size = constraints.maxHeight * 0.8; // 80% of the ListTile height
                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.format_quote,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
              title: Text(
                quote.text ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(quote.author ?? ''),
              onTap: () => Get.to(() => const QuoteDisplayScreen(), arguments: [
                {"first": quote.author},
                {"second": quote.text},
                {"third": quote.category},
              ]),
              trailing: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () => controller.saveItemToDatabase(quote),
              ),
            ),
          );
        },
      );
    });
  }
}
