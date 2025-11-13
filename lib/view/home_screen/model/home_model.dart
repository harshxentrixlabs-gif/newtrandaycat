import 'dart:convert';

GetLiveSellerListModel getLiveSellerListModelFromJson(String str) =>
    GetLiveSellerListModel.fromJson(json.decode(str));

String getLiveSellerListModelToJson(GetLiveSellerListModel data) => json.encode(data.toJson());

class GetLiveSellerListModel {
  GetLiveSellerListModel({
    bool? status,
    String? message,
    List<LiveSeller>? liveSeller,
  }) {
    _status = status;
    _message = message;
    _liveSeller = liveSeller;
  }

  GetLiveSellerListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['liveSeller'] != null) {
      _liveSeller = [];
      json['liveSeller'].forEach((v) {
        _liveSeller?.add(LiveSeller.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<LiveSeller>? _liveSeller;

  GetLiveSellerListModel copyWith({
    bool? status,
    String? message,
    List<LiveSeller>? liveSeller,
  }) =>
      GetLiveSellerListModel(
        status: status ?? _status,
        message: message ?? _message,
        liveSeller: liveSeller ?? _liveSeller,
      );

  bool? get status => _status;

  String? get message => _message;

  List<LiveSeller>? get liveSeller => _liveSeller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveSeller != null) {
      map['liveSeller'] = _liveSeller?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

LiveSeller liveSellerFromJson(String str) => LiveSeller.fromJson(json.decode(str));

String liveSellerToJson(LiveSeller data) => json.encode(data.toJson());

class LiveVideo {
  bool? status;
  String? message;
  int? total;
  List<LiveSeller>? liveSeller;

  LiveVideo({this.status, this.message, this.total, this.liveSeller});

  LiveVideo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['liveSeller'] != null) {
      liveSeller = <LiveSeller>[];
      json['liveSeller'].forEach((v) {
        liveSeller!.add(new LiveSeller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.liveSeller != null) {
      data['liveSeller'] = this.liveSeller!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveSeller {
  String? sId;
  String? firstName;
  String? lastName;
  String? businessTag;
  String? businessName;
  String? email;
  String? mobileNumber;
  String? image;
  bool? isLive;
  bool? isFake;
  String? video;
  Null? liveSellingHistoryId;
  int? view;

  LiveSeller(
      {this.sId,
        this.firstName,
        this.lastName,
        this.businessTag,
        this.businessName,
        this.email,
        this.mobileNumber,
        this.image,
        this.isLive,
        this.isFake,
        this.video,
        this.liveSellingHistoryId,
        this.view});

  LiveSeller.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    businessTag = json['businessTag'];
    businessName = json['businessName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    image = json['image'];
    isLive = json['isLive'];
    isFake = json['isFake'];
    video = json['video'];
    liveSellingHistoryId = json['liveSellingHistoryId'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['businessTag'] = this.businessTag;
    data['businessName'] = this.businessName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['image'] = this.image;
    data['isLive'] = this.isLive;
    data['isFake'] = this.isFake;
    data['video'] = this.video;
    data['liveSellingHistoryId'] = this.liveSellingHistoryId;
    data['view'] = this.view;
    return data;
  }
}

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


class ReelResponse {
  final bool status;
  final String message;
  final List<Reel> reels;

  ReelResponse({
    required this.status,
    required this.message,
    required this.reels,
  });

  factory ReelResponse.fromJson(Map<String, dynamic> json) {
    return ReelResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      reels: (json['reels'] as List<dynamic>?)
          ?.map((item) => Reel.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'reels': reels.map((e) => e.toJson()).toList(),
    };
  }
}

class Reel {
  final String? id;
  final String? title;
  final String? videoUrl;
  final String? thumbnail;
  final String? userId;

  Reel({
    this.id,
    this.title,
    this.videoUrl,
    this.thumbnail,
    this.userId,
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'userId': userId,
    };
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
  final String? id;
  final String? productName;
  final num? price;
  final int? review;
  final int? sold;
  final String? createStatus;
  final String? seller;
  final String? mainImage;
  final List<Attribute> attributes;
  final List<dynamic>? rating;

  JustForYouProduct({
    this.id,
    this.productName,
    this.price,
    this.review,
    this.sold,
    this.createStatus,
    this.seller,
    this.mainImage,
    this.attributes = const [],
    this.rating,
  });

  factory JustForYouProduct.fromJson(Map<String, dynamic> json) {
    return JustForYouProduct(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      price: json['price'] ?? 0,
      review: json['review'] ?? 0,
      sold: json['sold'] ?? 0,
      createStatus: json['createStatus'] ?? '',
      seller: json['seller'] ?? '',
      mainImage: json['mainImage'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e))
          .toList() ??
          [],
      rating: json['rating'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'review': review,
      'sold': sold,
      'createStatus': createStatus,
      'seller': seller,
      'mainImage': mainImage,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'rating': rating,
    };
  }
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    seller: json['seller'] as String? ?? '',
    mainImage: json['mainImage'] as String? ?? '',
    isFavorite: json['isFavorite'] as bool? ?? false,
  );

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

class Attribute {
  final String id;
  final String name;
  final List<String> value;

  Attribute({
    required this.id,
    required this.name,
    required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json['_id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    value: (json['value'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'value': value,
  };

  @override
  String toString() => jsonEncode(toJson());
}

