class StudentLogin {
  final String fullName;
  final String rollNumber;
  final String schoolCode;
  final String password;

  StudentLogin({
    required this.fullName,
    required this.rollNumber,
    required this.schoolCode,
    required this.password,
  });

  //convert studentlogin object to map to store in firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'rollNumber': rollNumber,
      'schoolCode': schoolCode,
      'password': password,
    };
  }

  //create a studentlogin object from firestore
  factory StudentLogin.fromMap(Map<String, dynamic> map) {
    return StudentLogin(
      fullName: map['fullName'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
      schoolCode: map['schoolCode'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
