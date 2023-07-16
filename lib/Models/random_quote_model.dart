class RandomQuoteModel {
  String? author;
  String? category;
  int? id;
  String? text;

  RandomQuoteModel({this.author, this.category, this.id, this.text});

  RandomQuoteModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    category = json['category'];
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['category'] = this.category;
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}
