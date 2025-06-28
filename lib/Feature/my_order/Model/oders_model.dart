// class OrdersModel {
//   final int bookingId;
//   final int userId;
//   final int providerId;
//   final int orderId;
//   final String address;
//   final String bookingDate;
//   final Order order;
//   final Service service;
//   final Provider provider;

//   OrdersModel({
//     required this.bookingId,
//     required this.userId,
//     required this.providerId,
//     required this.orderId,
//     required this.address,
//     required this.bookingDate,
//     required this.order,
//     required this.service,
//     required this.provider,
//   });

//   factory OrdersModel.fromJson(Map<String, dynamic> json) {
//     return OrdersModel(
//       bookingId: json['booking_id'],
//       userId: json['user_id'],
//       providerId: json['provider_id'],
//       orderId: json['order_id'],
//       address: json['address'],
//       bookingDate: json['booking_date'],
//       order: Order.fromJson(json['order']),
//       service: Service.fromJson(json['service']),
//       provider: Provider.fromJson(json['provider']),
//     );
//   }
// }

// class Order {
//   final int orderId;
//   final String status;
//   final double amount;
//   final String orderDate;

//   Order({
//     required this.orderId,
//     required this.status,
//     required this.amount,
//     required this.orderDate,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       orderId: json['order_id'],
//       status: json['status'],
//       amount: json['amount'].toDouble(),
//       orderDate: json['order_date'],
//     );
//   }
// }

// class Service {
//   final int serviceId;
//   final String serviceName;
//   final String description;
//   final int categoryId;
//   final String image;
//   final double price;

//   Service({
//     required this.serviceId,
//     required this.serviceName,
//     required this.description,
//     required this.categoryId,
//     required this.image,
//     required this.price,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       serviceId: json['service_id'],
//       serviceName: json['service_name'],
//       description: json['description'],
//       categoryId: json['category_id'],
//       image: json['image'],
//       price: json['price'].toDouble(),
//     );
//   }
// }

// class Provider {
//   final int providerId;
//   final int experience;
//   final String bio;
//   final String phone;
//   final String profilePicture;
//   final String startTime;
//   final String endTime;
//   final String location;

//   Provider({
//     required this.providerId,
//     required this.experience,
//     required this.bio,
//     required this.phone,
//     required this.profilePicture,
//     required this.startTime,
//     required this.endTime,
//     required this.location,
//   });

//   factory Provider.fromJson(Map<String, dynamic> json) {
//     return Provider(
//       providerId: json['provider_id'],
//       experience: json['experience'],
//       bio: json['bio'],
//       phone: json['phone_number'],
//       profilePicture: json['profile_picture'],
//       startTime: json['start_time'],
//       endTime: json['end_time'],
//       location: json['location'],
//     );
//   }
// }

class OrdersModel {
  final int bookingId;
  final int userId;
  final int providerId;
  final int orderId;
  final String address;
  final String bookingDate;
  final Order order;
  final Service service;
  final Provider provider;

  OrdersModel({
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.orderId,
    required this.address,
    required this.bookingDate,
    required this.order,
    required this.service,
    required this.provider,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      bookingId: json['booking_id'],
      userId: json['user_id'],
      providerId: json['provider_id'],
      orderId: json['order_id'],
      address: json['address'] ?? '',
      bookingDate: json['booking_date'] ?? '',
      order: Order.fromJson(json['order']),
      service: Service.fromJson(json['service']),
      provider: Provider.fromJson(json['provider']),
    );
  }
}

class Order {
  final int orderId;
  final String status;
  final double amount;
  final String orderDate;

  Order({
    required this.orderId,
    required this.status,
    required this.amount,
    required this.orderDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      status: json['status'] ?? '',
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : double.tryParse(json['amount'].toString()) ?? 0.0,
      orderDate: json['order_date'] ?? '',
    );
  }
}

class Service {
  final int serviceId;
  final String serviceName;
  final String description;
  final int categoryId;
  final String image;
  final double price;

  Service({
    required this.serviceId,
    required this.serviceName,
    required this.description,
    required this.categoryId,
    required this.image,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'],
      serviceName: json['service_name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'],
      image: json['image'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}

class Provider {
  final int providerId;
  final int experience;
  final String bio;
  final String phone;
  final String? profilePicture;
  final String startTime;
  final String endTime;
  final String location;

  Provider({
    required this.providerId,
    required this.experience,
    required this.bio,
    required this.phone,
    required this.profilePicture,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      providerId: json['provider_id'],
      experience: json['experience'],
      bio: json['bio'] ?? '',
      phone: json['phone_number'] ?? '',
      profilePicture: json['profile_picture']?.toString(), // null-safe
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

// class OrdersModel {
//   final int bookingId;
//   final int userId;
//   final int providerId;
//   final int orderId;
//   final String address;
//   final String bookingDate;
//   final Order order;
//   final Service service;
//   final Provider provider;

//   OrdersModel({
//     required this.bookingId,
//     required this.userId,
//     required this.providerId,
//     required this.orderId,
//     required this.address,
//     required this.bookingDate,
//     required this.order,
//     required this.service,
//     required this.provider,
//   });

//   factory OrdersModel.fromJson(Map<String, dynamic> json) {
//     return OrdersModel(
//       bookingId: json['booking_id'],
//       userId: json['user_id'],
//       providerId: json['provider_id'],
//       orderId: json['order_id'],
//       address: json['address'],
//       bookingDate: json['booking_date'],
//       order: Order.fromJson(json['order']),
//       service: Service.fromJson(json['service']),
//       provider: Provider.fromJson(json['provider']),
//     );
//   }
// }

// class Order {
//   final int orderId;
//   final String status;
//   final double amount;
//   final String orderDate;

//   Order({
//     required this.orderId,
//     required this.status,
//     required this.amount,
//     required this.orderDate,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       orderId: json['order_id'],
//       status: json['status'],
//       amount: double.parse(json['amount']), // Fixed here
//       orderDate: json['order_date'],
//     );
//   }
// }

// class Service {
//   final int serviceId;
//   final String serviceName;
//   final String description;
//   final int categoryId;
//   final String image;
//   final double price;

//   Service({
//     required this.serviceId,
//     required this.serviceName,
//     required this.description,
//     required this.categoryId,
//     required this.image,
//     required this.price,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       serviceId: json['service_id'],
//       serviceName: json['service_name'],
//       description: json['description'],
//       categoryId: json['category_id'],
//       image: json['image'],
//       price: double.parse(json['price']), // Fixed here
//     );
//   }
// }

// class Provider {
//   final int providerId;
//   final int experience;
//   final String bio;
//   final String phone;
//   final String profilePicture;
//   final String startTime;
//   final String endTime;
//   final String location;

//   Provider({
//     required this.providerId,
//     required this.experience,
//     required this.bio,
//     required this.phone,
//     required this.profilePicture,
//     required this.startTime,
//     required this.endTime,
//     required this.location,
//   });

//   factory Provider.fromJson(Map<String, dynamic> json) {
//     return Provider(
//       providerId: json['provider_id'],
//       experience: json['experience'],
//       bio: json['bio'],
//       phone: json['phone_number'],
//       profilePicture: json['profile_picture'],
//       startTime: json['start_time'],
//       endTime: json['end_time'],
//       location: json['location'],
//     );
//   }
// }
