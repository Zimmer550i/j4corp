class SenderInfo {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;

  SenderInfo({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory SenderInfo.fromJson(Map<String, dynamic> json) {
    return SenderInfo(
      userId: json['user_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

class MessageModel {
  final int id;
  final int room;
  final int senderId;
  final SenderInfo senderInfo;
  final String text;
  final String? attachmentUrl;
  final String attachmentType;
  final DateTime createdAt;
  bool isRead;

  MessageModel({
    required this.id,
    required this.room,
    required this.senderId,
    required this.senderInfo,
    required this.text,
    this.attachmentUrl,
    required this.attachmentType,
    required this.createdAt,
    required this.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? 0,
      room: json['room'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      senderInfo: SenderInfo.fromJson(json['sender_info'] ?? {}),
      text: json['text'] ?? '',
      attachmentUrl: json['attachment_url'],
      attachmentType: json['attachment_type'] ?? 'none',
      createdAt: DateTime.parse(json['created_at'] as String),
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room': room,
      'sender_id': senderId,
      'sender_info': senderInfo.toJson(),
      'text': text,
      'attachment_url': attachmentUrl,
      'attachment_type': attachmentType,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
    };
  }
}
