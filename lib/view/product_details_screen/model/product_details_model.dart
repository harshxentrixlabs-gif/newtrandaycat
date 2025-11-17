class ProductModel {
  bool status;
  String message;
  List<Product> product;

  ProductModel({
    required this.status,
    required this.message,
    required this.product,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      status: json['status'],
      message: json['message'],
      product:
      (json['product'] as List).map((e) => Product.fromJson(e)).toList(),
    );
  }
}

class Product {
  String id;
  String productCode;
  int price;
  int shippingCharges;
  List<String> images;
  int review;
  int sold;
  bool isOutOfStock;
  bool isNewCollection;
  String createStatus;
  String updateStatus;
  List<Attribute> attributes;
  String productName;
  String description;
  Category category;
  SubCategory subCategory;
  Seller seller;
  String mainImage;
  bool allowOffer;
  int auctionDuration;
  int auctionStartingPrice;
  bool enableAuction;
  bool enableReservePrice;
  int minimumOfferPrice;
  int reservePrice;
  List<dynamic> rating;
  int followerCount;
  dynamic latestBidPrice;
  bool isFollow;
  bool isFavorite;

  Product({
    required this.id,
    required this.productCode,
    required this.price,
    required this.shippingCharges,
    required this.images,
    required this.review,
    required this.sold,
    required this.isOutOfStock,
    required this.isNewCollection,
    required this.createStatus,
    required this.updateStatus,
    required this.attributes,
    required this.productName,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.seller,
    required this.mainImage,
    required this.allowOffer,
    required this.auctionDuration,
    required this.auctionStartingPrice,
    required this.enableAuction,
    required this.enableReservePrice,
    required this.minimumOfferPrice,
    required this.reservePrice,
    required this.rating,
    required this.followerCount,
    required this.latestBidPrice,
    required this.isFollow,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productCode: json['productCode'],
      price: json['price'],
      shippingCharges: json['shippingCharges'],
      images: List<String>.from(json['images']),
      review: json['review'],
      sold: json['sold'],
      isOutOfStock: json['isOutOfStock'],
      isNewCollection: json['isNewCollection'],
      createStatus: json['createStatus'],
      updateStatus: json['updateStatus'],
      attributes: (json['attributes'] as List)
          .map((e) => Attribute.fromJson(e))
          .toList(),
      productName: json['productName'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      subCategory: SubCategory.fromJson(json['subCategory']),
      seller: Seller.fromJson(json['seller']),
      mainImage: json['mainImage'],
      allowOffer: json['allowOffer'],
      auctionDuration: json['auctionDuration'],
      auctionStartingPrice: json['auctionStartingPrice'],
      enableAuction: json['enableAuction'],
      enableReservePrice: json['enableReservePrice'],
      minimumOfferPrice: json['minimumOfferPrice'],
      reservePrice: json['reservePrice'],
      rating: json['rating'],
      followerCount: json['followerCount'],
      latestBidPrice: json['latestBidPrice'],
      isFollow: json['isFollow'],
      isFavorite: json['isFavorite'],
    );
  }
}

class Attribute {
  String name;
  List<String> value;
  String id;

  Attribute({
    required this.name,
    required this.value,
    required this.id,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      name: json['name'],
      value: List<String>.from(json['value']),
      id: json['_id'],
    );
  }
}

class Category {
  String id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class SubCategory {
  String id;
  String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Seller {
  String id;
  Address address;
  String firstName;
  String lastName;
  String businessTag;
  String businessName;
  String image;

  Seller({
    required this.id,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.businessTag,
    required this.businessName,
    required this.image,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'],
      address: Address.fromJson(json['address']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      businessTag: json['businessTag'],
      businessName: json['businessName'],
      image: json['image'],
    );
  }
}

class Address {
  String city;
  String state;
  String country;

  Address({
    required this.city,
    required this.state,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}
