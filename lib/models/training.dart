// models/training.dart - Enhanced
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wil_flutter_application/models/training_module.dart';

class Training {
  final String? id;
  final String employeeId;
  final String title;
  final String provider;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String certificateUrl;
  final DateTime createdAt;
  final String? certificatePdfUrl;
  final String? certificateFileName;
  final double progress;
  final List<TrainingModule> modules;
  final String? trainingProgramId;
  final String? assignedBy;
  final String? assignedReason;
  final DateTime? assignedDate;
  final DateTime? completedDate;

  Training({
    this.id,
    required this.employeeId,
    required this.title,
    required this.provider,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.certificateUrl,
    required this.createdAt,
    this.certificatePdfUrl,
    this.certificateFileName,
    this.progress = 0.0,
    this.modules = const [],
    this.trainingProgramId,
    this.assignedBy,
    this.assignedReason,
    this.assignedDate,
    this.completedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'title': title,
      'provider': provider,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'status': status,
      'certificateUrl': certificateUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'certificatePdfUrl': certificatePdfUrl,
      'certificateFileName': certificateFileName,
      'progress': progress,
      'trainingProgramId': trainingProgramId,
      'assignedBy': assignedBy,
      'assignedReason': assignedReason,
      'assignedDate': assignedDate?.millisecondsSinceEpoch,
      'completedDate': completedDate?.millisecondsSinceEpoch,
    };
  }

  // factory Training.fromMap(String id, Map<String, dynamic> map) {
  //   return Training(
  //     id: id,
  //     employeeId: map['employeeId'] ?? '',
  //     title: map['title'] ?? '',
  //     provider: map['provider'] ?? '',
  //     description: map['description'] ?? '',
  //     startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
  //     endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
  //     status: map['status'] ?? 'Pending',
  //     certificateUrl: map['certificateUrl'] ?? '',
  //     createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
  //     certificatePdfUrl: map['certificatePdfUrl'],
  //     certificateFileName: map['certificateFileName'],
  //     progress: map['progress']?.toDouble() ?? 0.0,
  //     trainingProgramId: map['trainingProgramId'],
  //     assignedBy: map['assignedBy'],
  //     assignedReason: map['assignedReason'],
  //     assignedDate: map['assignedDate'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['assignedDate'])
  //         : null,
  //     completedDate: map['completedDate'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['completedDate'])
  //         : null,
  //   );
  // }

  Training copyWith({
    String? title,
    String? provider,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? certificateUrl,
    String? certificatePdfUrl,
    String? certificateFileName,
    double? progress,
    DateTime? completedDate,
  }) {
    return Training(
      id: id,
      employeeId: employeeId,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      certificateUrl: certificateUrl ?? this.certificateUrl,
      createdAt: createdAt,
      certificatePdfUrl: certificatePdfUrl ?? this.certificatePdfUrl,
      certificateFileName: certificateFileName ?? this.certificateFileName,
      progress: progress ?? this.progress,
      trainingProgramId: trainingProgramId,
      assignedBy: assignedBy,
      assignedReason: assignedReason,
      assignedDate: assignedDate,
      completedDate: completedDate ?? this.completedDate,
    );
  }

  // Helper getters
  bool get isAssigned => assignedBy == 'admin';
  bool get isSelfAdded => assignedBy == 'employee' || assignedBy == null;
  bool get canEdit => isSelfAdded && status != 'Completed';
  bool get canComplete => status != 'Completed';
  bool get isCompleted => status == 'Completed';
  bool get isInProgress => status == 'In Progress';
  bool get isPending => status == 'Pending';

  double get progressPercentage => progress * 100;
  bool get isUpcoming => startDate.isAfter(DateTime.now());
  bool get isOngoing =>
      startDate.isBefore(DateTime.now()) && endDate.isAfter(DateTime.now());

  String? get name => null;
  // In your Flutter training.dart model, add this helper method
  static DateTime _parseDate(dynamic date) {
    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    } else if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      return DateTime.parse(date);
    } else {
      return DateTime.now();
    }
  }

  // Update the fromMap factory constructor to use the helper
  factory Training.fromMap(String id, Map<String, dynamic> map) {
    return Training(
      id: id,
      employeeId: map['employeeId'] ?? '',
      title: map['title'] ?? '',
      provider: map['provider'] ?? '',
      description: map['description'] ?? '',
      startDate: _parseDate(map['startDate']),
      endDate: _parseDate(map['endDate']),
      status: map['status'] ?? 'Pending',
      certificateUrl: map['certificateUrl'] ?? '',
      createdAt: _parseDate(map['createdAt']),
      certificatePdfUrl: map['certificatePdfUrl'],
      certificateFileName: map['certificateFileName'],
      progress: map['progress']?.toDouble() ?? 0.0,
      trainingProgramId: map['trainingProgramId'],
      assignedBy: map['assignedBy'],
      assignedReason: map['assignedReason'],
      assignedDate: map['assignedDate'] != null
          ? _parseDate(map['assignedDate'])
          : null,
      completedDate: map['completedDate'] != null
          ? _parseDate(map['completedDate'])
          : null,
    );
  }
}
