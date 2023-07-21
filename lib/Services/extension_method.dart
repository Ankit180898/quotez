import 'package:quotez/Models/random_quote_model.dart';

import '../Models/saved_item_model.dart';

extension DisplayItemToDatabaseItem on RandomQuoteModel {
  Item toDatabaseItem() {
    return Item(
      text: text!,
      author:author!,
      category: category!,
    );
  }
}

extension DatabaseItemToDisplayItem on Item {
  Item toDisplayItem({required String category}) {
    return Item(
      text: text,
      author:author,
      category: category,
    );
  }
}
