class Skill {
  final String? id;
  final String employeeId;
  final String name;
  final String level;
  final String category;
  final int yearsOfExperience;
  final DateTime createdAt;

  Skill({
    this.id,
    required this.employeeId,
    required this.name,
    required this.level,
    required this.category,
    required this.yearsOfExperience,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'name': name,
      'level': level,
      'category': category,
      'yearsOfExperience': yearsOfExperience,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Skill.fromMap(String id, Map<String, dynamic> map) {
    return Skill(
      id: id,
      employeeId: map['employeeId'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
      category: map['category'] ?? '',
      yearsOfExperience: map['yearsOfExperience'] ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}
