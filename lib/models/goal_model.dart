class GoalModel {
  final String id;
  final String title;
  final String categoryId;
  final int totalSessions;
  final int completedSessions;
  final String type; // 'weekly' or 'monthly'

  GoalModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.totalSessions,
    required this.completedSessions,
    required this.type,
  });

  factory GoalModel.fromMap(Map<String, dynamic> map, String id) {
    return GoalModel(
      id: id,
      title: map['title'] ?? '',
      categoryId: map['categoryId'] ?? '',
      totalSessions: map['totalSessions'] ?? 5,
      completedSessions: map['completedSessions'] ?? 0,
      type: map['type'] ?? 'weekly',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'categoryId': categoryId,
      'totalSessions': totalSessions,
      'completedSessions': completedSessions,
      'type': type,
    };
  }

  GoalModel copyWith({
    String? id,
    String? title,
    String? categoryId,
    int? totalSessions,
    int? completedSessions,
    String? type,
  }) {
    return GoalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      totalSessions: totalSessions ?? this.totalSessions,
      completedSessions: completedSessions ?? this.completedSessions,
      type: type ?? this.type,
    );
  }

  double get progressPercentage {
    if (totalSessions == 0) return 0.0;
    return (completedSessions / totalSessions).clamp(0.0, 1.0);
  }
}
