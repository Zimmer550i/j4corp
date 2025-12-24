class LastMessage {
  final int id;
  final String text;
  final int senderId;
  final DateTime createdAt;
  final String attachmentType;

  LastMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.attachmentType,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      senderId: json['sender_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      attachmentType: json['attachment_type'] ?? 'none',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender_id': senderId,
      'created_at': createdAt.toIso8601String(),
      'attachment_type': attachmentType,
    };
  }
}

class OtherUser {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePic;

  OtherUser({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePic,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    return OtherUser(
      userId: json['user_id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profilePic: json['profile_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_pic': profilePic,
    };
  }
}

class ChatModel {
  final int id;
  final int user;
  final int staff;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LastMessage lastMessage;
  final OtherUser otherUser;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.user,
    required this.staff,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    required this.otherUser,
    required this.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      staff: json['staff'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastMessage: LastMessage.fromJson(json['last_message'] ?? {}),
      otherUser: OtherUser.fromJson(json['other_user'] ?? {}),
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'staff': staff,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_message': lastMessage.toJson(),
      'other_user': otherUser.toJson(),
      'unread_count': unreadCount,
    };
  }
}
