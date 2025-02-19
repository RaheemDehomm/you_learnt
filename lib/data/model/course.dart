class Course {
  final int? id;
  final String name;
  final String description;
  String? image;
  final String sectionName;
  final String price;
  final String hours;

  Course({
    this.id,
    required this.name,
    required this.description,
    this.image,
    required this.sectionName,
    required this.price,
    required this.hours,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'desc': description,
        'image': image,
        'sectionName': sectionName,
        'price': price,
        'hours': hours,
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] ?? 0,
        name: json['name'],
        description: json['desc'],
        image: json['image'],
        sectionName: json['sectionName'],
        price: json['price'],
        hours: json['hours'],
      );
}
