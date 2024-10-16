class Item {
  final String text;
  final String author;
  final String category;

  Item({required this.text,required this.author,required this.category, int? id});
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'author':author,
      'category': category,
    };
  }
  static Item fromMap(Map<String, dynamic> map) {
    return Item(
     text: map['text'], author: map['author'], category: map['category'],
    );
  }
}
