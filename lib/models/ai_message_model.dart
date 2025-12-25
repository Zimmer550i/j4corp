class AiMessageModel {
  final String role;
  final String content;
  final DateTime timestamp;

  AiMessageModel({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  factory AiMessageModel.fromJson(Map<String, dynamic> json) {
    return AiMessageModel(
      role: json['role'] ?? '',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
