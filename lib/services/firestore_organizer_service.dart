// services/firestore_organizer_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOrganizerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Organized paths for different document types
  static String employeePath(String employeeId) => 'employees/$employeeId';
  static String skillsPath(String employeeId) => 'employees/$employeeId/skills';
  static String qualificationsPath(String employeeId) => 'employees/$employeeId/qualifications';
  static String trainingsPath(String employeeId) => 'employees/$employeeId/trainings';
  static String userChatsPath(String userId) => 'users/$userId/chats';

  // Add employee with organized structure
  Future<void> addEmployeeWithOrganization(String employeeId, Map<String, dynamic> data) async {
    await _firestore.collection('employees').doc(employeeId).set({
      ...data,
      '_organized': true,
      '_createdAt': FieldValue.serverTimestamp(),
      '_updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Add skill with metadata
  Future<void> addSkillWithOrganization(String employeeId, Map<String, dynamic> data) async {
    await _firestore.collection(skillsPath(employeeId)).add({
      ...data,
      '_organized': true,
      '_createdAt': FieldValue.serverTimestamp(),
      '_updatedAt': FieldValue.serverTimestamp(),
      '_category': _categorizeSkill(data['name']),
    });
  }

  // Categorize skills automatically
  String _categorizeSkill(String skillName) {
    final technicalSkills = ['programming', 'development', 'coding', 'software', 'technical'];
    final softSkills = ['communication', 'leadership', 'teamwork', 'management'];
    
    if (technicalSkills.any((skill) => skillName.toLowerCase().contains(skill))) {
      return 'Technical';
    } else if (softSkills.any((skill) => skillName.toLowerCase().contains(skill))) {
      return 'Soft Skills';
    }
    return 'Other';
  }

  // Get organized query for skills
  Query<Map<String, dynamic>> getOrganizedSkillsQuery(String employeeId) {
    return _firestore
        .collection(skillsPath(employeeId))
        .orderBy('_createdAt', descending: true)
        .where('_organized', isEqualTo: true);
  }

  // Batch write for multiple operations
  Future<void> batchOrganizedOperations(List<Map<String, dynamic>> operations) async {
    final batch = _firestore.batch();
    
    for (final operation in operations) {
      final String path = operation['path'];
      final Map<String, dynamic> data = operation['data'];
      final String type = operation['type']; // 'set', 'update', 'delete'
      
      final docRef = _firestore.doc(path);
      
      switch (type) {
        case 'set':
          batch.set(docRef, data);
          break;
        case 'update':
          batch.update(docRef, data);
          break;
        case 'delete':
          batch.delete(docRef);
          break;
      }
    }
    
    await batch.commit();
  }
}