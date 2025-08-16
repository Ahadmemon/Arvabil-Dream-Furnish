class ProductModel {
  final String? category;
  final num? price;
  final List<String>? image;
  final String? name;
  final String? description;
  final String? id;
  final String? selected3dImage; // NEW FIELD

  // final List<FeedbackModel>? feedbacks;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final int? quantity;

  ProductModel({
    this.category,
    this.price,
    this.image,
    this.name,
    this.description,
    this.id,
    this.selected3dImage, // NEW FIELD
    this.createdOn,
    this.updatedOn,
    this.quantity,
    // this.feedbacks,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      category: json['category']?.toString(),
      price: _parseNumber(json['price']),
      image: _parseImageList(json['image']),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      id: json['_id']?.toString(),
      selected3dImage: json['selected3dImage']?.toString(), // NEW FIELD
      createdOn: _parseDateTime(json['createdOn']),
      updatedOn: _parseDateTime(json['updatedOn']),
      quantity: _parseInteger(json['quantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (image != null && image!.isNotEmpty) 'image': image,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (id != null) '_id': id,
      if (selected3dImage != null)
        'selected3dImage': selected3dImage, // NEW FIELD
      if (createdOn != null) 'createdOn': createdOn!.toIso8601String(),
      if (updatedOn != null) 'updatedOn': updatedOn!.toIso8601String(),
      if (quantity != null) 'quantity': quantity,
    };
  }

  // Helper methods
  static num? _parseNumber(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  static int? _parseInteger(dynamic value) {
    final number = _parseNumber(value);
    return number?.toInt();
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }

  static List<String>? _parseImageList(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return null;
  }

  ProductModel copyWith({
    String? category,
    num? price,
    List<String>? image,
    String? name,
    String? description,
    String? id,
    String? selected3dImage, // NEW FIELD
    DateTime? createdOn,
    DateTime? updatedOn,
    int? quantity,
  }) {
    return ProductModel(
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      id: id ?? this.id,
      selected3dImage: selected3dImage ?? this.selected3dImage, // NEW FIELD
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      quantity: quantity ?? this.quantity,
    );
  }
}
