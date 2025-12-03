class ProductDetailsModel {
  final String id;
  final String productName;
  final String productCode;
  final String? description;
  final double price;
  final double shippingCharges;
  final bool allowOffer;
  final String mainImage;
  final List<String> images;
  final List<ProductAttribute> attributes;
  final int review;
  final int sold;
  final bool isOutOfStock;
  final bool isNewCollection;
  final Seller seller;
  final Category category;
  final Category subCategory;
  final int followerCount;
  bool isFavorite;

  ProductDetailsModel({
    required this.id,
    required this.productName,
    required this.productCode,
    this.description,
    required this.price,
    required this.shippingCharges,
    required this.allowOffer,
    required this.mainImage,
    required this.images,
    required this.attributes,
    required this.review,
    required this.sold,
    required this.isOutOfStock,
    required this.isNewCollection,
    required this.seller,
    required this.category,
    required this.subCategory,
    required this.followerCount,
    required this.isFavorite,
  });

  /// 🔥 JSON Parse FIXED (safe bool handling)
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json["_id"] ?? "",
      productName: json["productName"] ?? "",
      productCode: json["productCode"] ?? "",
      description: json["description"],
      price: (json["price"] ?? 0).toDouble(),
      shippingCharges: (json["shippingCharges"] ?? 0).toDouble(),
      allowOffer: json["allowOffer"] ?? false,
      mainImage: json["mainImage"] ?? "",
      images: List<String>.from(json["images"] ?? []),
      attributes: (json["attributes"] as List? ?? [])
          .map((e) => ProductAttribute.fromJson(e))
          .toList(),
      review: json["review"] ?? 0,
      sold: json["sold"] ?? 0,
      isOutOfStock: json["isOutOfStock"] ?? false,
      isNewCollection: json["isNewCollection"] ?? false,
      seller: Seller.fromJson(json["seller"] ?? {}),
      category: Category.fromJson(json["category"] ?? {}),
      subCategory: Category.fromJson(json["subCategory"] ?? {}),
      followerCount: json["followerCount"] ?? 0,
      isFavorite: json["isFavorite"] is bool
          ? json["isFavorite"]
          : (json["isFavorite"] == 1),
    );
  }

  /// For updates if needed
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "productName": productName,
      "productCode": productCode,
      "description": description,
      "price": price,
      "shippingCharges": shippingCharges,
      "allowOffer": allowOffer,
      "mainImage": mainImage,
      "images": images,
      "attributes": attributes,
      "review": review,
      "sold": sold,
      "isOutOfStock": isOutOfStock,
      "isNewCollection": isNewCollection,
      "seller": seller,
      "category": category,
      "subCategory": subCategory,
      "followerCount": followerCount,
      "isFavorite": isFavorite,
    };
  }

  ProductDetailsModel copyWith({bool? isFavorite}) {
    return ProductDetailsModel(
      id: id,
      productName: productName,
      productCode: productCode,
      description: description,
      price: price,
      shippingCharges: shippingCharges,
      allowOffer: allowOffer,
      mainImage: mainImage,
      images: images,
      attributes: attributes,
      review: review,
      sold: sold,
      isOutOfStock: isOutOfStock,
      isNewCollection: isNewCollection,
      seller: seller,
      category: category,
      subCategory: subCategory,
      followerCount: followerCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ProductAttribute {
  final String id;
  final String name;
  final List<String> values;
  final String? image;

  ProductAttribute({
    required this.id,
    required this.name,
    required this.values,
    this.image,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json["_id"],
      name: json["name"] ?? "",
      values: List<String>.from(json["values"] ?? []),
      image: json["image"],
    );
  }
}

class Seller {
  final String id;
  final String? image;
  final String firstName;
  final String lastName;
  final String businessTag;
  final String businessName;

  Seller({
    required this.id,
    this.image,
    required this.firstName,
    required this.lastName,
    required this.businessTag,
    required this.businessName,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json["_id"] ?? "",
      image: json["image"],
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      businessTag: json["businessTag"] ?? "",
      businessName: json["businessName"] ?? "",
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}
