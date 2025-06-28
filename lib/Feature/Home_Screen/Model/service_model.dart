class ServiceModel {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final String price;
  final String? image;
  final int bookingsCount;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    this.image,
    required this.bookingsCount,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['service_id'],
      name: json['service_name'],
      description: json['description'],
      categoryId: json['category_id'],
      price: json['price'],
      image: json['image'],
      bookingsCount: json['bookings_count'],
    );
  }
}
