class Section {
  final int id;
  final String name;
  String? image;
  final bool isHasExam;
  Section({
    required this.name,
    this.image,
    required this.id,
    required this.isHasExam,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isHasExam': isHasExam,
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      name: json['name'],
      image: json['image'],
      id: json['id'],
      isHasExam: json['isHasExam'],
    );
  }
}
