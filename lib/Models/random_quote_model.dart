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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['id'] = this.id;
    data['category'] = this.category;
    data['text'] = this.text;
    return data;
  }
}
