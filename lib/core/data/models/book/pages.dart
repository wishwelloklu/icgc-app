// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pages {
  final int pageNumber;
  final String? title;
  final String content;

  Pages({
    required this.pageNumber,
    this.title,
    required this.content,
  });

  // Factory method to create a Pages from JSON
  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      pageNumber: json['page_number'],
      title: json['title'],
      content: json['content'],
    );
  }

  // Method to convert a Pages object to JSON
  Map<String, dynamic> toJson() {
    return {
      'page_number': pageNumber,
      'title': title,
      'content': content,
    };
  }

  Pages copyWith({
    int? pageNumber,
    String? title,
    String? content,
  }) {
    return Pages(
      pageNumber: pageNumber ?? this.pageNumber,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
