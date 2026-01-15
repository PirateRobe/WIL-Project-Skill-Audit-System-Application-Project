// models/employee.dart
class Employee {
  final String? id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String position;
  final String department;
  final DateTime hireDate;
  final DateTime createdAt;
  final String? profileImageUrl;
  final String? employeeId; // Now this will be auto-generated

  Employee({
    this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.position,
    required this.department,
    required this.hireDate,
    required this.createdAt,
    this.profileImageUrl,
    this.employeeId, // Auto-generated, not required in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'position': position,
      'department': department,
      'hireDate': hireDate.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profileImageUrl': profileImageUrl,
      'employeeId': employeeId, // Will be auto-generated
    };
  }

  factory Employee.fromMap(String id, Map<String, dynamic> map) {
    return Employee(
      id: id,
      userId: map['userId'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      position: map['position'] ?? '',
      department: map['department'] ?? '',
      hireDate: DateTime.fromMillisecondsSinceEpoch(map['hireDate']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      profileImageUrl: map['profileImageUrl'],
      employeeId: map['employeeId'], // Will be loaded from Firestore
    );
  }

  get imageUrl => null;

  Employee copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? position,
    String? department,
    String? profileImageUrl,
    String? employeeId,
    required String imageUrl,
  }) {
    return Employee(
      id: id,
      userId: userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      department: department ?? this.department,
      hireDate: hireDate,
      createdAt: createdAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      employeeId: employeeId ?? this.employeeId,
    );
  }
}
