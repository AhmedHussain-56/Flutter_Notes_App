class Note {
  String title;
  String body;

  Note({required this.title, required this.body});

  Map<String, dynamic> toJson() => {'title': title, 'body': body};

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(title: json['title'], body: json['body']);
}
