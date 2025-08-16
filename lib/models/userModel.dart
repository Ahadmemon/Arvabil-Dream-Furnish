class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String? profileImage;
  final String role;
  String? token;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.profileImage,
    required this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString() ?? 'No Name',
      password: json['password']?.toString() ?? 'No Password',
      email: json['email']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      role: json['role']?.toString() ?? 'user',
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    // Only include '_id' if it's not null
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
      'role': role,
      'token': token,
    };

    if (id != null) {
      data['_id'] = id; // Include '_id' only if it's not null
    }

    return data;
  }
}

// class UserModel {
//   String? sId;
//   String? name;
//   String? email;
//   String? password;
//   String? phone;
//   String? address;
//   List<dynamic>? cart;
//   String? token;
//   String? role;
//   String? createdOn;
//   String? updatedOn;
//
//   UserModel({
//     this.sId,
//     this.name,
//     this.email,
//     this.password,
//     this.phone,
//     this.address,
//     this.cart,
//     this.role,
//     this.createdOn,
//     this.updatedOn,
//     this.token,
//   });
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     phone = json['phone'];
//     address = json['address'];
//     cart =
//         (json['cart'] as List?)?.map((e) => e as Map<String, dynamic>).toList();
//     token = json['token'];
//     role = json['role'];
//     createdOn = json['createdOn'];
//     updatedOn = json['updatedOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     if (sId != null) data['_id'] = sId; // Include only if it's not null
//     data['name'] = name;
//     data['email'] = email;
//     data['role'] = role;
//     data['password'] = password;
//     data['phone'] = phone;
//     data['address'] = address;
//     data['cart'] = cart;
//     data['token'] = token;
//     data['createdOn'] = createdOn;
//     data['updatedOn'] = updatedOn;
//     return data;
//   }
//
//   UserModel copyWith({
//     String? sId,
//     String? name,
//     String? email,
//     String? password,
//     String? phone,
//     String? address,
//     List<dynamic>? cart,
//     String? token,
//     String? role,
//     String? createdOn,
//     String? updatedOn,
//   }) {
//     return UserModel(
//       sId: sId ?? this.sId,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       phone: phone ?? this.phone,
//       address: address ?? this.address,
//       cart: cart ?? this.cart,
//       token: token ?? this.token,
//       role: role ?? this.role,
//       createdOn: createdOn ?? this.createdOn,
//       updatedOn: updatedOn ?? this.updatedOn,
//     );
//   }
// }
