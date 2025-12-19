class Unit {
  final int id;
  final String vin;
  final String brand;
  final String model;
  final int year;
  final DateTime purchaseDate;
  final String storeLocation;

  final String? color;
  final String? additionalNotes;
  final String? image;

  final DateTime createdAt;
  final DateTime updatedAt;
  final int registrar;

  Unit({
    required this.id,
    required this.vin,
    required this.brand,
    required this.model,
    required this.year,
    required this.purchaseDate,
    required this.storeLocation,
    this.color,
    this.additionalNotes,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.registrar,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      vin: json['vin'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      purchaseDate: DateTime.parse(json['purchase_date']),
      storeLocation: json['store_location'],
      color: json['color'],
      additionalNotes: json['additional_notes'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      registrar: json['registrar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vin': vin,
      'brand': brand,
      'model': model,
      'year': year,
      'purchase_date': purchaseDate.toIso8601String().split('T').first,
      'store_location': storeLocation,
      'color': color,
      'additional_notes': additionalNotes,
      'image': image,
    };
  }
}