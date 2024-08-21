class RandomQuoteModel {
  String? author;
  int? id;
  String? category;
  String? text;

  RandomQuoteModel({this.author, this.id, this.category, this.text});

  RandomQuoteModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    id = json['id'];
    category = json['category'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['id'] = id;
    data['category'] = category;
    data['text'] = text;
    return data;
  }
}
