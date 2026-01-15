// services/firestore_services.dart - Enhanced with Debugging
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Employee CRUD Operations
  Future<void> addEmployee(Map<String, dynamic> employeeData) async {
    await _firestore.collection('employees').add(employeeData);
  }

  Future<void> updateEmployee(
    String employeeId,
    Map<String, dynamic> employeeData,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .update(employeeData);
  }

  Future<DocumentSnapshot> getEmployee(String employeeId) async {
    print('🔍 Fetching employee: $employeeId');
    return await _firestore.collection('employees').doc(employeeId).get();
  }

  Stream<QuerySnapshot> getEmployeesByUserId(String userId) {
    print('🔍 Fetching employees by user ID: $userId');
    return _firestore
        .collection('employees')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  // Skills CRUD Operations
  Future<void> addSkill(
    String employeeId,
    Map<String, dynamic> skillData,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('skills')
        .add(skillData);
  }

  Future<void> updateSkill(
    String employeeId,
    String skillId,
    Map<String, dynamic> skillData,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('skills')
        .doc(skillId)
        .update(skillData);
  }

  Future<void> deleteSkill(String employeeId, String skillId) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('skills')
        .doc(skillId)
        .delete();
  }

  Stream<QuerySnapshot> getSkills(String employeeId) {
    print('🔍 Fetching skills for employee: $employeeId');
    return _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('skills')
        .snapshots();
  }

  // Qualifications CRUD Operations
  Future<void> addQualification(
    String employeeId,
    Map<String, dynamic> qualificationData,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('qualifications')
        .add(qualificationData);
  }

  Future<void> updateQualification(
    String employeeId,
    String qualificationId,
    Map<String, dynamic> qualificationData,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('qualifications')
        .doc(qualificationId)
        .update(qualificationData);
  }

  Future<void> deleteQualification(
    String employeeId,
    String qualificationId,
  ) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('qualifications')
        .doc(qualificationId)
        .delete();
  }

  Stream<QuerySnapshot> getQualifications(String employeeId) {
    print('🔍 Fetching qualifications for employee: $employeeId');
    return _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('qualifications')
        .snapshots();
  }

  // Trainings CRUD Operations
  Future<void> addTraining(
    String employeeId,
    Map<String, dynamic> trainingData,
  ) async {
    print('➕ Adding training for employee: $employeeId');
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('trainings')
        .add(trainingData);
  }

  Future<void> updateTraining(
    String employeeId,
    String trainingId,
    Map<String, dynamic> trainingData,
  ) async {
    print('✏️ Updating training: $trainingId for employee: $employeeId');
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('trainings')
        .doc(trainingId)
        .update(trainingData);
  }

  Future<void> deleteTraining(String employeeId, String trainingId) async {
    await _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('trainings')
        .doc(trainingId)
        .delete();
  }

  Stream<QuerySnapshot> getTrainings(String employeeId) {
    print('🔍 Fetching trainings for employee: $employeeId');
    return _firestore
        .collection('employees')
        .doc(employeeId)
        .collection('trainings')
        .snapshots();
  }

  // NEW: Debug method to check if collections exist
  Future<void> debugCollections(String employeeId) async {
    try {
      print('🐛 DEBUG COLLECTIONS FOR EMPLOYEE: $employeeId');
      
      // Check if employee exists
      final employeeDoc = await _firestore.collection('employees').doc(employeeId).get();
      print('📄 Employee exists: ${employeeDoc.exists}');
      
      if (employeeDoc.exists) {
        print('📊 Employee data: ${employeeDoc.data()}');
      }

      // Check skills subcollection
      final skillsSnapshot = await _firestore
          .collection('employees')
          .doc(employeeId)
          .collection('skills')
          .get();
      print('🛠️ Skills count: ${skillsSnapshot.docs.length}');

      // Check qualifications subcollection
      final qualificationsSnapshot = await _firestore
          .collection('employees')
          .doc(employeeId)
          .collection('qualifications')
          .get();
      print('🎓 Qualifications count: ${qualificationsSnapshot.docs.length}');

      // Check trainings subcollection
      final trainingsSnapshot = await _firestore
          .collection('employees')
          .doc(employeeId)
          .collection('trainings')
          .get();
      print('📚 Trainings count: ${trainingsSnapshot.docs.length}');

    } catch (e) {
      print('❌ Debug error: $e');
    }
  }
}