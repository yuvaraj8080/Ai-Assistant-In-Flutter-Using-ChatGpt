class CourseModel {
  final String name;
  final String content;
  final String urlLink;

  CourseModel({
    required this.name,
    required this.content,
    required this.urlLink,
  });

  // Factory method to create a CourseModel from a JSON map
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      name: json['name'],
      content: json['content'],
      urlLink: json['urlLink'],
    );
  }

  // Method to convert a CourseModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'content': content,
      'urlLink': urlLink,
    };
  }
}