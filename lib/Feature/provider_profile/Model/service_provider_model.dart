class Review {
  final String userName;
  final String reviewText;
  final int rating;
  final String reviewDate;

  Review({
    required this.userName,
    required this.reviewText,
    required this.rating,
    required this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['user_name'] ?? '',
      reviewText: json['review_text'] ?? '',
      rating: json['rating'] ?? 0,
      reviewDate: json['review_date'] ?? '',
    );
  }
}

class ServiceProvider {
  final String name;
  final String phone;
  final String bio;
  final double rating;
  final String? startTime;
  final String? endTime;
  final num experience;
  final String availability;
  final String location;
  final String? profilePicture;
  final String category;
  final List<Review> reviews;

  ServiceProvider({
    required this.name,
    required this.phone,
    required this.bio,
    required this.startTime,
    required this.endTime,
    required this.rating,
    required this.experience,
    required this.availability,
    required this.location,
    required this.profilePicture,
    required this.category,
    required this.reviews,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      bio: json['bio'] ?? '',
      experience: json['experience'] ?? 0,
      availability: json['availability'] ?? '',
      location: json['location'] ?? '',
      profilePicture: json['profile_picture'],
      category: json['service'] ??
          '', // "service" is used in your JSON instead of "category"
      startTime: json['start_time']?.toString(),
      endTime: json['end_time']?.toString(),
      rating: (json['average_rating'] ?? 4.5).toDouble(),
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }
}
