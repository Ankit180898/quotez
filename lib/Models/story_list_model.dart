class StoryListModel {
  String? sId;
  String? title;
  String? author;
  String? story;
  String? moral;

  StoryListModel({this.sId, this.title, this.author, this.story, this.moral});

  StoryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    author = json['author'];
    story = json['story'];
    moral = json['moral'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['story'] = this.story;
    data['moral'] = this.moral;
    return data;
  }
}
