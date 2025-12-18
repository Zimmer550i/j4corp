class User {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String username;
  final String? profilePic;
  final String? profilePicUrl;
  final String phone;
  final String address;
  final String zipCode;
  final DateTime dob;
  final bool isVerified;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.username,
    this.profilePic,
    this.profilePicUrl,
    required this.phone,
    required this.address,
    required this.zipCode,
    required this.dob,
    required this.isVerified,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      username: json['username'],
      profilePic: json['profile_pic'],
      profilePicUrl: json['profile_pic_url'],
      phone: json['phone'],
      address: json['address'],
      zipCode: json['zip_code'],
      dob: DateTime.parse(json['dob']),
      isVerified: json['is_verified'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'username': username,
      'profile_pic': profilePic,
      'profile_pic_url': profilePicUrl,
      'phone': phone,
      'address': address,
      'zip_code': zipCode,
      'dob': dob.toIso8601String(),
      'is_verified': isVerified,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    int? userId,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    String? username,
    String? profilePic,
    String? profilePicUrl,
    String? phone,
    String? address,
    String? zipCode,
    DateTime? dob,
    bool? isVerified,
    bool? isActive,
    bool? isStaff,
    bool? isSuperuser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      profilePic: profilePic ?? this.profilePic,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
      dob: dob ?? this.dob,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      isStaff: isStaff ?? this.isStaff,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
