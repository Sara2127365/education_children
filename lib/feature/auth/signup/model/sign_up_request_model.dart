class SignupRequestModel {
  final String childName;
  final int age;
  final String gender;
  final String mentorGender;
  final String language;
  final String dialect;
  final String parentEmail;
  final String parentPhone;

  SignupRequestModel({
    required this.childName,
    required this.age,
    required this.gender,
    required this.mentorGender,
    required this.language,
    required this.dialect,
    required this.parentEmail,
    required this.parentPhone,
  });

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) {
    return SignupRequestModel(
      childName: json['child_name'] as String? ?? '',
      age: json['age'] is int
          ? json['age'] as int
          : int.tryParse(json['age']?.toString() ?? '') ?? 0,
      gender: json['gender'] as String? ?? '',
      mentorGender: json['mentor_gender'] as String? ?? '',
      language: json['language'] as String? ?? '',
      dialect: json['dialect'] as String? ?? '',
      parentEmail: json['parent_email'] as String? ?? '',
      parentPhone: json['parent_phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_name': childName,
      'age': age,
      'gender': gender,
      'mentor_gender': mentorGender,
      'language': language,
      'dialect': dialect,
      'parent_email': parentEmail,
      'parent_phone': parentPhone,
    };
  }
}
