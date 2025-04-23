class ProductModel {
  final String name;
  final String quantity;
  String? notes;
  String? imagePath;

  ProductModel({
    required this.name,
    required this.quantity,
    this.notes,
    this.imagePath,
  });
  ProductModel copyWith({
    String? name,
    String? quantity,
    String? notes,
    String? imagePath,
  }) {
    return ProductModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
