class Note {
  int? id;
  String? title;
  String? description;
  String? image;

  // String? data;

  Note( this.title, this.description, this.image,
      // this.data,
  );

  Note.fromMap(Map map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.image = map['image'];
    // this.data = map['data'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'title': this.title,
      'description': this.description,
      'image' : this.image
      // 'data': this.data,
    };
    if (this.id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
