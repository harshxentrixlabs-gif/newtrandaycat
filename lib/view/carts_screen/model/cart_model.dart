import '../../home_screen/model/home_model.dart';

class CartModel {
  String id;
  int totalItems;
  int totalShippingCharges;
  int subTotal;
  List<CartItem> items;
  String userId;

  CartModel({
    required this.id,
    required this.totalItems,
    required this.totalShippingCharges,
    required this.subTotal,
    required this.items,
    required this.userId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id']?.toString() ?? "",
      totalItems: int.tryParse(json['totalItems']?.toString() ?? "0") ?? 0,
      totalShippingCharges:
      int.tryParse(json['totalShippingCharges']?.toString() ?? "0") ?? 0,
      subTotal: int.tryParse(json['subTotal']?.toString() ?? "0") ?? 0,

      // SAFE LIST / MAP HANDLING
      items: _parseItems(json['items']),

      userId: json['userId']?.toString() ?? "",
    );
  }

  static List<CartItem> _parseItems(dynamic data) {
    if (data is List) {
      return data.map((e) => CartItem.fromJson(e)).toList();
    } else if (data is Map) {
      return data.values.map((e) => CartItem.fromJson(e)).toList();
    }
    return [];
  }

  CartModel copyWith({
    String? id,
    int? totalItems,
    int? totalShippingCharges,
    int? subTotal,
    List<CartItem>? items,
    String? userId,
  }) {
    return CartModel(
      id: id ?? this.id,
      totalItems: totalItems ?? this.totalItems,
      totalShippingCharges:
      totalShippingCharges ?? this.totalShippingCharges,
      subTotal: subTotal ?? this.subTotal,
      items: items ?? this.items,
      userId: userId ?? this.userId,
    );
  }
}


class CartItem {
  final Product productId;
  final String sellerId;
  final int purchasedTimeProductPrice;
  final int purchasedTimeShippingCharges;
  final String productCode;
  final int productQuantity;
  final List attributesArray;
  final String id;

  CartItem({
    required this.productId,
    required this.sellerId,
    required this.purchasedTimeProductPrice,
    required this.purchasedTimeShippingCharges,
    required this.productCode,
    required this.productQuantity,
    required this.attributesArray,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: Product.fromJson(json['productId'] ?? {}),

      sellerId: json['sellerId']?.toString() ?? "",

      purchasedTimeProductPrice:
      int.tryParse(json['purchasedTimeProductPrice']?.toString() ?? "0") ??
          0,

      purchasedTimeShippingCharges: int.tryParse(
          json['purchasedTimeShippingCharges']?.toString() ?? "0") ??
          0,

      productCode: json['productCode']?.toString() ?? "",

      productQuantity:
      int.tryParse(json['productQuantity']?.toString() ?? "1") ?? 1,

      attributesArray: _parseAttributes(json['attributesArray']),

      id: json['_id']?.toString() ?? "",
    );
  }

  static List _parseAttributes(dynamic data) {
    if (data is List) return data;
    if (data is Map) return data.values.toList();
    return [];
  }

  CartItem copyWith({
    Product? productId,
    String? sellerId,
    int? purchasedTimeProductPrice,
    int? purchasedTimeShippingCharges,
    String? productCode,
    int? productQuantity,
    List? attributesArray,
    String? id,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      purchasedTimeProductPrice:
      purchasedTimeProductPrice ?? this.purchasedTimeProductPrice,
      purchasedTimeShippingCharges:
      purchasedTimeShippingCharges ?? this.purchasedTimeShippingCharges,
      productCode: productCode ?? this.productCode,
      productQuantity: productQuantity ?? this.productQuantity,
      attributesArray: attributesArray ?? this.attributesArray,
      id: id ?? this.id,
    );
  }
}


class Product {
  final String id;
  final String productName;
  final bool enableAuction;
  final dynamic auctionEndDate;
  final String mainImage;
  final List<AttributeModel> attributes;

  Product({
    required this.id,
    required this.productName,
    required this.enableAuction,
    required this.auctionEndDate,
    required this.mainImage,
    required this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString() ?? "",
      productName: json['productName']?.toString() ?? "",
      enableAuction: json['enableAuction'] == true,
      auctionEndDate: json['auctionEndDate'],
      mainImage: json['mainImage']?.toString() ?? "",
      attributes: _parseAttributes(json['attributes']),
    );
  }

  static List<AttributeModel> _parseAttributes(dynamic data) {
    if (data is List) {
      return data.map((e) => AttributeModel.fromJson(e)).toList();
    } else if (data is Map) {
      return data.values.map((e) => AttributeModel.fromJson(e)).toList();
    }
    return [];
  }
}

class AttributeModel {
  final String id;
  final String name;
  final List<String> values;
  final String image;

  AttributeModel({
    required this.id,
    required this.name,
    required this.values,
    required this.image,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['_id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      values: _parseValues(json['values']),
      image: json['image']?.toString() ?? "",
    );
  }

  static List<String> _parseValues(dynamic data) {
    if (data is List) {
      return data.map((e) => e.toString()).toList();
    } else if (data is Map) {
      return data.values.map((e) => e.toString()).toList();
    }
    return [];
  }
}


class GetAllCartProductsModel {
  bool? status;
  String? message;
  Data? data;

  GetAllCartProductsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllCartProductsModel.fromJson(Map<String, dynamic> json) => GetAllCartProductsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}
