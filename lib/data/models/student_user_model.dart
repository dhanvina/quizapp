class StudentLoginModel {
  final String fullName;
  final String rollNumber;
  final String schoolCode;
  final String password;

  StudentLoginModel({
    required this.fullName,
    required this.rollNumber,
    required this.schoolCode,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'rollNumber': rollNumber,
      'schoolCode': schoolCode,
      'password': password,
    };
  }

  factory StudentLoginModel.fromMap(Map<String, dynamic> map) {
    return StudentLoginModel(
      fullName: map['fullName'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
      schoolCode: map['schoolCode'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
