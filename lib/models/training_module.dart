// models/training.dart - Add this class
class TrainingModule {
  final String title;
  final String description;
  final Duration duration;
  final bool isCompleted;

  TrainingModule({
    required this.title,
    required this.description,
    required this.duration,
    this.isCompleted = false,
  });

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'duration': duration.inMinutes, // Store duration in minutes
      'isCompleted': isCompleted,
    };
  }

  // Create from Firestore data
  factory TrainingModule.fromMap(Map<String, dynamic> map) {
    return TrainingModule(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      duration: Duration(minutes: map['duration'] ?? 0),
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  TrainingModule copyWith({
    String? title,
    String? description,
    Duration? duration,
    bool? isCompleted,
  }) {
    return TrainingModule(
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}