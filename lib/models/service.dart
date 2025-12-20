class Service {
  final int id;
  final String fullName;
  final String email;
  final String modelName;
  final String location;
  final DateTime date;
  final String details;
  final bool hasServicedBefore;
  final DateTime createdAt;
  final DateTime updatedAt;

  Service({
    required this.id,
    required this.fullName,
    required this.email,
    required this.modelName,
    required this.location,
    required this.date,
    required this.details,
    required this.hasServicedBefore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      modelName: json['model_name'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      details: json['details'],
      hasServicedBefore: json['has_serviced_before'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'model_name': modelName,
      'location': location,
      'date': date.toIso8601String().split('T').first,
      'details': details,
      'has_serviced_before': hasServicedBefore,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}