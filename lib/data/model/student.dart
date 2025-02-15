class Student {
  final String name;
  final String email;
  final String phone;
  final String typeOfStudy;
  final String dateOfBirth;
  final String address;
  final String subject;
  final String status;
  final int? id;
  final String locationStudy;
  final String? sectionName;

  Student({
    required this.name,
    required this.email,
    required this.phone,
    required this.typeOfStudy,
    required this.dateOfBirth,
    required this.address,
    required this.subject,
    required this.status,
    this.id,
    required this.locationStudy,
    required this.sectionName,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'typeOfStudy': typeOfStudy,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'subject': subject,
      'status': status,
      'locationStudy': locationStudy,
      'sectionName': sectionName,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      typeOfStudy: json['typeOfStudy'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      subject: json['subject'],
      status: json['status'],
      id: json['id'],
      locationStudy: json['locationStudy'],
      sectionName: json['sectionName'],
    );
  }
}
