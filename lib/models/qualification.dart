// models/qualification.dart
class Qualification {
  final String? id;
  final String employeeId;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final int yearCompleted;
  final String grade;
  final DateTime createdAt;
  final String? certificatePdfUrl; // NEW: PDF certificate
  final String? certificateFileName; // NEW: PDF file name
  final String? transcriptPdfUrl; // NEW: Transcript PDF
  final String? transcriptFileName; // NEW: Transcript file name

  Qualification({
    this.id,
    required this.employeeId,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.yearCompleted,
    required this.grade,
    required this.createdAt,
    this.certificatePdfUrl, // NEW
    this.certificateFileName, // NEW
    this.transcriptPdfUrl, // NEW
    this.transcriptFileName, // NEW
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'yearCompleted': yearCompleted,
      'grade': grade,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'certificatePdfUrl': certificatePdfUrl, // NEW
      'certificateFileName': certificateFileName, // NEW
      'transcriptPdfUrl': transcriptPdfUrl, // NEW
      'transcriptFileName': transcriptFileName, // NEW
    };
  }

  factory Qualification.fromMap(String id, Map<String, dynamic> map) {
    return Qualification(
      id: id,
      employeeId: map['employeeId'] ?? '',
      institution: map['institution'] ?? '',
      degree: map['degree'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      yearCompleted: map['yearCompleted'] ?? 0,
      grade: map['grade'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      certificatePdfUrl: map['certificatePdfUrl'], // NEW
      certificateFileName: map['certificateFileName'], // NEW
      transcriptPdfUrl: map['transcriptPdfUrl'], // NEW
      transcriptFileName: map['transcriptFileName'], // NEW
    );
  }

  // NEW: Copy with method for updates
  Qualification copyWith({
    String? institution,
    String? degree,
    String? fieldOfStudy,
    int? yearCompleted,
    String? grade,
    String? certificatePdfUrl,
    String? certificateFileName,
    String? transcriptPdfUrl,
    String? transcriptFileName,
  }) {
    return Qualification(
      id: id,
      employeeId: employeeId,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      yearCompleted: yearCompleted ?? this.yearCompleted,
      grade: grade ?? this.grade,
      createdAt: createdAt,
      certificatePdfUrl: certificatePdfUrl ?? this.certificatePdfUrl,
      certificateFileName: certificateFileName ?? this.certificateFileName,
      transcriptPdfUrl: transcriptPdfUrl ?? this.transcriptPdfUrl,
      transcriptFileName: transcriptFileName ?? this.transcriptFileName,
    );
  }
}
