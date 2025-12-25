class SessionModel {
  final String sessionId;
  final String userId;
  final String title;
  final DateTime createdAt;

  SessionModel({
    required this.sessionId,
    required this.userId,
    required this.title,
    required this.createdAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['session_id'],
      userId: json['user_id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'user_id': userId,
      'title': title,
      'created_at': createdAt.toIso8601String(),
    };
  }

  SessionModel copyWith({
    String? sessionId,
    String? userId,
    String? title,
    DateTime? createdAt,
  }) {
    return SessionModel(
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}