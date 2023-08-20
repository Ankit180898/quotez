class PoetryListModel {
  String? title;
  String? author;
  List<String>? lines;
  String? linecount;

  PoetryListModel({this.title, this.author, this.lines, this.linecount});

  PoetryListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    lines = json['lines'].cast<String>();
    linecount = json['linecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['lines'] = this.lines;
    data['linecount'] = this.linecount;
    return data;
  }
}
