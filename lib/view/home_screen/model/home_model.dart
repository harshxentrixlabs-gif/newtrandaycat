import 'dart:convert';







SelectedProducts selectedProductsFromJson(String str) => SelectedProducts.fromJson(json.decode(str));

String selectedProductsToJson(SelectedProducts data) => json.encode(data.toJson());

class SelectedProducts {
  SelectedProducts({
    String? id,
    int? price,
    bool? isSelect,
    List<Attributes>? attributes,
    String? productName,
    String? seller,
    String? mainImage,
  }) {
    _id = id;
    _price = price;
    _isSelect = isSelect;
    _attributes = attributes;
    _productName = productName;
    _seller = seller;
    _mainImage = mainImage;
  }

  SelectedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _isSelect = json['isSelect'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _seller = json['seller'];
    _mainImage = json['mainImage'];
  }

  String? _id;
  int? _price;
  bool? _isSelect;
  List<Attributes>? _attributes;
  String? _productName;
  String? _seller;
  String? _mainImage;

  SelectedProducts copyWith({
    String? id,
    int? price,
    bool? isSelect,
    List<Attributes>? attributes,
    String? productName,
    String? seller,
    String? mainImage,
  }) =>
      SelectedProducts(
        id: id ?? _id,
        price: price ?? _price,
        isSelect: isSelect ?? _isSelect,
        attributes: attributes ?? _attributes,
        productName: productName ?? _productName,
        seller: seller ?? _seller,
        mainImage: mainImage ?? _mainImage,
      );

  String? get id => _id;

  int? get price => _price;

  bool? get isSelect => _isSelect;

  List<Attributes>? get attributes => _attributes;

  String? get productName => _productName;

  String? get seller => _seller;

  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['isSelect'] = _isSelect;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['seller'] = _seller;
    map['mainImage'] = _mainImage;
    return map;
  }
}

Attributes attributesFromJson(String str) => Attributes.fromJson(json.decode(str));

String attributesToJson(Attributes data) => json.encode(data.toJson());

class Attributes {
  Attributes({
    String? name,
    List<String>? value,
    String? id,
  }) {
    _name = name;
    _value = value;
    _id = id;
  }

  Attributes.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'] != null ? json['value'].cast<String>() : [];
    _id = json['_id'];
  }

  String? _name;
  List<String>? _value;
  String? _id;

  Attributes copyWith({
    String? name,
    List<String>? value,
    String? id,
  }) =>
      Attributes(
        name: name ?? _name,
        value: value ?? _value,
        id: id ?? _id,
      );

  String? get name => _name;

  List<String>? get value => _value;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    map['_id'] = _id;
    return map;
  }
}





class JustForYouProductResponse {
  final bool status;
  final String message;
  final List<JustForYouProduct> justForYouProducts;

  JustForYouProductResponse({
    required this.status,
    required this.message,
    required this.justForYouProducts,
  });

  factory JustForYouProductResponse.fromJson(Map<String, dynamic> json) {
    return JustForYouProductResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      justForYouProducts: (json['justForYouProducts'] as List<dynamic>?)
          ?.map((e) => JustForYouProduct.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'justForYouProducts':
      justForYouProducts.map((e) => e.toJson()).toList(),
    };
  }
}

class JustForYouProduct {
  final String id;
  final String productName;
  final num price;
  final int review;
  final int sold;
  final String createStatus;
  final String seller;
  final String mainImage;
  final String description;
  final List<Attribute> attributes;
  final List<dynamic> rating;

  /// ⭐ ADD THIS
  bool isFavorite;

  JustForYouProduct({
    this.id = '',
    this.productName = '',
    this.price = 0,
    this.review = 0,
    this.sold = 0,
    this.createStatus = '',
    this.seller = '',
    this.mainImage = '',
    this.description = '',
    this.attributes = const [],
    this.rating = const [],

    /// ⭐ ADD THIS
    this.isFavorite = false,
  });

  factory JustForYouProduct.fromJson(Map<String, dynamic> json) {
    return JustForYouProduct(
      id: (json['_id'] ?? "").toString(),
      productName: (json['productName'] ?? "").toString(),
      price: json['price'] ?? 0,
      review: json['review'] ?? 0,
      sold: json['sold'] ?? 0,
      createStatus: (json['createStatus'] ?? "").toString(),
      seller: (json['seller'] ?? "").toString(),
      description: (json['description'] ?? "").toString(),
      mainImage: (json['mainImage'] ?? "").toString(),

      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((e) => Attribute.fromJson(e))
          .toList(),

      rating: json['rating'] as List<dynamic>? ?? [],

      /// ⭐ 100% NULL SAFE
      isFavorite: (json['isFavorite'] ?? false) == true,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'review': review,
      'description': description,
      'sold': sold,
      'createStatus': createStatus,
      'seller': seller,
      'mainImage': mainImage,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'rating': rating,

      /// ⭐ ADD THIS
      'isFavorite': isFavorite,
    };
  }
}



class Attribute {
  final String id;
  final String name;
  final List<String> values;

  Attribute({
    required this.id,
    required this.name,
    required this.values,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    final rawValues = json['values'];

    return Attribute(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      values: rawValues is List
          ? rawValues.map((e) => e.toString()).toList()
          : <String>[],  // <-- NULL SAFEF
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'values': values,
  };
}



class ApiResponse {
  final bool status;
  final String message;
  final List<Product> products;

  ApiResponse({
    required this.status,
    required this.message,
    required this.products,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    status: json['status'] as bool,
    message: json['message'] as String,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'products': products.map((p) => p.toJson()).toList(),
  };

  @override
  String toString() => jsonEncode(toJson());
}

class Product {
  final String id;
  final String productCode;
  final num price;
  final num shippingCharges;
  final List<String> images;
  final int review;
  final int sold;
  final bool isOutOfStock;
  final bool isNewCollection;
  final List<Attribute> attributes;
  final String productName;
  final String description;
  final String category;
  final String seller;
  final String mainImage;
  final bool isFavorite;

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
    required this.attributes,
    required this.productName,
    required this.description,
    required this.category,
    required this.seller,
    required this.mainImage,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json['_id'] as String,
      productCode: json['productCode'] as String? ?? '',
      price: json['price'] ?? 0,
      shippingCharges: json['shippingCharges'] ?? 0,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      review: (json['review'] is int) ? json['review'] as int : (json['review'] as num?)?.toInt() ?? 0,
      sold: (json['sold'] is int) ? json['sold'] as int : (json['sold'] as num?)?.toInt() ?? 0,
      isOutOfStock: json['isOutOfStock'] as bool? ?? false,
      isNewCollection: json['isNewCollection'] as bool? ?? false,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      productName: json['productName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      seller: json['seller'] as  String? ?? '',
      mainImage: json['mainImage'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'productCode': productCode,
    'price': price,
    'shippingCharges': shippingCharges,
    'images': images,
    'review': review,
    'sold': sold,
    'isOutOfStock': isOutOfStock,
    'isNewCollection': isNewCollection,
    'attributes': attributes.map((a) => a.toJson()).toList(),
    'productName': productName,
    'description': description,
    'category': category,
    'seller': seller,
    'mainImage': mainImage,
    'isFavorite': isFavorite,
  };

  Product copyWith({
    String? id,
    String? productCode,
    num? price,
    num? shippingCharges,
    List<String>? images,
    int? review,
    int? sold,
    bool? isOutOfStock,
    bool? isNewCollection,
    List<Attribute>? attributes,
    String? productName,
    String? description,
    String? category,
    String? seller,
    String? mainImage,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        productCode: productCode ?? this.productCode,
        price: price ?? this.price,
        shippingCharges: shippingCharges ?? this.shippingCharges,
        images: images ?? this.images,
        review: review ?? this.review,
        sold: sold ?? this.sold,
        isOutOfStock: isOutOfStock ?? this.isOutOfStock,
        isNewCollection: isNewCollection ?? this.isNewCollection,
        attributes: attributes ?? this.attributes,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        category: category ?? this.category,
        seller: seller ?? this.seller,
        mainImage: mainImage ?? this.mainImage,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  String toString() => jsonEncode(toJson());
}



class LiveSellerResponse {
  final bool status;
  final String message;
  final int total;
  final List<LiveSeller> liveSeller;

  LiveSellerResponse({
    required this.status,
    required this.message,
    required this.total,
    required this.liveSeller,
  });

  factory LiveSellerResponse.fromJson(Map<String, dynamic> json) {
    return LiveSellerResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      liveSeller: (json['liveSeller'] as List<dynamic>?)
          ?.map((e) => LiveSeller.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'total': total,
      'liveSeller': liveSeller.map((e) => e.toJson()).toList(),
    };
  }
}

class LiveSeller {
  final String id;
  final String firstName;
  final String lastName;
  final String businessTag;
  final String businessName;
  final String email;
  final String mobileNumber;
  final String image;
  final bool isLive;
  final bool isFake;
  final String video;
  final String? liveSellingHistoryId;
  final int view;

  LiveSeller({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.businessTag,
    required this.businessName,
    required this.email,
    required this.mobileNumber,
    required this.image,
    required this.isLive,
    required this.isFake,
    required this.video,
    required this.liveSellingHistoryId,
    required this.view,
  });

  factory LiveSeller.fromJson(Map<String, dynamic> json) {
    return LiveSeller(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      businessTag: json['businessTag'] ?? '',
      businessName: json['businessName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      image: json['image'] ?? '',
      isLive: json['isLive'] ?? false,
      isFake: json['isFake'] ?? false,
      video: json['video'] ?? '',
      liveSellingHistoryId: json['liveSellingHistoryId'],
      view: json['view'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'businessTag': businessTag,
      'businessName': businessName,
      'email': email,
      'mobileNumber': mobileNumber,
      'image': image,
      'isLive': isLive,
      'isFake': isFake,
      'video': video,
      'liveSellingHistoryId': liveSellingHistoryId,
      'view': view,
    };
  }
}

class ReelsResponse {
  final bool status;
  final String message;
  final List<Reel> reels;

  ReelsResponse({
    required this.status,
    required this.message,
    required this.reels,
  });

  factory ReelsResponse.fromJson(Map<String, dynamic> json) {
    return ReelsResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      reels: json["reels"] == null
          ? []
          : List<Reel>.from(json["reels"].map((x) => Reel.fromJson(x))),
    );
  }
}

/// Reel Model
class Reel {
  final String id;
  final String thumbnail;
  final String video;
  final String description;
  final int videoType;
  final int thumbnailType;
  final List<Product> productId;
  final Seller sellerId;
  final int duration;
  final int like;
  final bool isFake;
  final String createdAt;
  bool isLike;   // ✅ Make it non-final so it can change

  Reel({
    required this.id,
    required this.thumbnail,
    required this.video,
    required this.description,
    required this.videoType,
    required this.thumbnailType,
    required this.productId,
    required this.sellerId,
    required this.duration,
    required this.like,
    required this.isFake,
    required this.createdAt,
    this.isLike = false,   // ✅ default value here
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json["_id"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      video: json["video"] ?? "",
      description: json["description"] ?? "",
      videoType: json["videoType"] ?? 0,
      thumbnailType: json["thumbnailType"] ?? 0,
      productId: json["productId"] == null
          ? []
          : List<Product>.from(
          json["productId"].map((x) => Product.fromJson(x))),
      sellerId: Seller.fromJson(json["sellerId"] ?? {}),
      duration: json["duration"] ?? 0,
      like: json["like"] ?? 0,
      isFake: json["isFake"] ?? false,
      createdAt: json["createdAt"] ?? "",
      isLike: json["isLike"] ?? false,   // ✅ API value if available
    );
  }
}


/// Seller Model
class Seller {
  final String id;
  final String firstName;
  final String lastName;
  final String businessTag;
  final String businessName;
  final String image;

  Seller({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.businessTag,
    required this.businessName,
    required this.image,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json["_id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      businessTag: json["businessTag"] ?? "",
      businessName: json["businessName"] ?? "",
      image: json["image"] ?? "",
    );
  }
}


class PopularProducts {
  bool? status;
  String? message;
  List<Data>? data;

  PopularProducts({this.status, this.message, this.data});

  PopularProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Data {
  String? sId;
  String? productCode;
  int? price;
  int? shippingCharges;
  String? productName;
  String? description;
  String? mainImage;
  List<dynamic>? rating;   // FIXED ⭐
  String? categoryName;

  Data({
    this.sId,
    this.productCode,
    this.price,
    this.shippingCharges,
    this.productName,
    this.description,
    this.mainImage,
    this.rating,
    this.categoryName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productCode = json['productCode'];
    price = json['price'];
    shippingCharges = json['shippingCharges'];
    productName = json['productName'];
    description = json['description'];
    mainImage = json['mainImage'];

    rating = json['rating'] != null ? List<dynamic>.from(json['rating']) : [];

    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    data['productCode'] = this.productCode;
    data['price'] = this.price;
    data['shippingCharges'] = this.shippingCharges;
    data['productName'] = this.productName;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;

    /// SAFE EXPORT
    data['rating'] = this.rating;

    data['categoryName'] = this.categoryName;
    return data;
  }
}



class RelatedProductsResponse {
  bool? status;
  String? message;
  List<RelatedProduct> relatedProducts;

  RelatedProductsResponse({
    this.status,
    this.message,
    required this.relatedProducts,
  });

  factory RelatedProductsResponse.fromJson(Map<String, dynamic> json) {
    return RelatedProductsResponse(
      status: json["status"],
      message: json["message"],
      relatedProducts: json["relatedProducts"] == null
          ? []
          : List<RelatedProduct>.from(
          json["relatedProducts"].map((x) => RelatedProduct.fromJson(x))),
    );
  }
}

class RelatedProduct {
  String? id;
  String? productName;
  String? productCode;
  String? description;
  String? mainImage;
  int? price;
  String? category;
  bool isFavorite;


  RelatedProduct({
    this.id,
    this.productName,
    this.productCode,
    this.description,
    this.mainImage,
    this.price,
    this.category,
    this.isFavorite = false,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json["_id"]?.toString(),
      productName: json["productName"]?.toString(),
      productCode: json["productCode"]?.toString(),
      description: json["description"] is String
          ? json["description"]
          : (json["description"]?["text"] ?? ""),
      mainImage: json["mainImage"] is String
          ? json["mainImage"]
          : (json["mainImage"]?["url"] ?? ""),
      price: json["price"] is int
          ? json["price"]
          : int.tryParse(json["price"]?.toString() ?? "0"),
      category: json["category"]?.toString(),
      isFavorite: json["isFavorite"] ?? false,
    );
  }

  RelatedProduct copyWith({
    bool? isFavorite,
  }) {
    return RelatedProduct(
      id: id,
      productName: productName,
      productCode: productCode,
      description: description,
      mainImage: mainImage,
      price: price,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}


