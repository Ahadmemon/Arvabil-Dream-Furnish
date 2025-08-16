class CategoryModel {
  String? sid;
  String? name;
  String? description;
  String? image;
  DateTime? createdOn;
  DateTime? updatedOn;

  CategoryModel(
      {this.sid,
      this.name,
      this.description,
      this.image,
      this.createdOn,
      this.updatedOn});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdOn =
        json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
    updatedOn =
        json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sid,
      'name': name,
      'image': image,
      'description': description,
      'createdOn': createdOn?.toIso8601String(),
      'updatedOn': updatedOn?.toIso8601String(),
    };
  }
}
// class OrderModel {
//   String? id;
//   User? user;
//   List<Items>? items;
//   DateTime? createdOn;
//   DateTime? updatedOn;
//
//   OrderModel({this.id, this.user, this.items, this.createdOn, this.updatedOn});
//
//   OrderModel.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     if (json['items'] != null) {
//       items = (json['items'] as List).map((v) => Items.fromJson(v)).toList();
//     }
//     createdOn =
//         json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
//     updatedOn =
//         json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'user': user?.toJson(),
//       'items': items?.map((v) => v.toJson()).toList(),
//       'createdOn': createdOn?.toIso8601String(),
//       'updatedOn': updatedOn?.toIso8601String(),
//     };
//   }
// }
//
// class User {
//   String? id;
//   String? fullName;
//   String? email;
//   String? phone;
//   String? address;
//   String? city;
//   String? country;
//   String? state;
//   DateTime? createdOn;
//   DateTime? updatedOn;
//
//   User({
//     this.id,
//     this.fullName,
//     this.email,
//     this.phone,
//     this.address,
//     this.city,
//     this.country,
//     this.state,
//     this.createdOn,
//     this.updatedOn,
//   });
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     fullName = json['fullName'];
//     email = json['email'];
//     phone = json['phone'];
//     address = json['address'];
//     city = json['city'];
//     country = json['country'];
//     state = json['state'];
//     createdOn =
//         json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
//     updatedOn =
//         json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'fullName': fullName,
//       'email': email,
//       'phone': phone,
//       'address': address,
//       'city': city,
//       'country': country,
//       'state': state,
//       'createdOn': createdOn?.toIso8601String(),
//       'updatedOn': updatedOn?.toIso8601String(),
//     };
//   }
// }
//
// class Items {
//   String? status;
//   Item? item;
//   int? quantity;
//   String? id;
//
//   Items({this.status, this.item, this.quantity, this.id});
//
//   Items.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     item = json['item'] != null ? Item.fromJson(json['item']) : null;
//     quantity = json['quantity'];
//     id = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'item': item?.toJson(),
//       'quantity': quantity,
//       '_id': id,
//     };
//   }
// }
//
// class Item {
//   String? id;
//   String? category;
//   int? price;
//   List<String>? images;
//   String? title;
//   String? description;
//   DateTime? createdOn;
//   DateTime? updatedOn;
//
//   Item({
//     this.id,
//     this.category,
//     this.price,
//     this.images,
//     this.title,
//     this.description,
//     this.createdOn,
//     this.updatedOn,
//   });
//
//   Item.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     category = json['category'];
//     price = json['price'];
//     images = (json['image'] as List?)?.map((v) => v.toString()).toList();
//     title = json['title'];
//     description = json['description'];
//     createdOn =
//         json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
//     updatedOn =
//         json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'category': category,
//       'price': price,
//       'image': images,
//       'title': title,
//       'description': description,
//       'createdOn': createdOn?.toIso8601String(),
//       'updatedOn': updatedOn?.toIso8601String(),
//     };
//   }
// }
