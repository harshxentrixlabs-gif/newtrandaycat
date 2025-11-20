class CartModel {
  final String id;
  final int totalItems;
  final int totalShippingCharges;
  final int subTotal;
  final List<CartItem> items;
  final String userId;

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
      id: json['_id'] ?? "",
      totalItems: json['totalItems'] ?? 0,
      totalShippingCharges: json['totalShippingCharges'] ?? 0,
      subTotal: json['subTotal'] ?? 0,
      items: (json['items'] as List? ?? [])
          .map((e) => CartItem.fromJson(e))
          .toList(),
      userId: json['userId'] ?? "",
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
  final List<dynamic> attributesArray;
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
      sellerId: json['sellerId'] ?? "",
      purchasedTimeProductPrice: json['purchasedTimeProductPrice'] ?? 0,
      purchasedTimeShippingCharges: json['purchasedTimeShippingCharges'] ?? 0,
      productCode: json['productCode'] ?? "",
      productQuantity: json['productQuantity'] ?? 0,
      attributesArray: json['attributesArray'] ?? [],
      id: json['_id'] ?? "",
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
      id: json['_id'] ?? "",
      productName: json['productName'] ?? "",
      enableAuction: json['enableAuction'] ?? false,
      auctionEndDate: json['auctionEndDate'],
      mainImage: json['mainImage'] ?? "",
      attributes: (json['attributes'] as List? ?? [])
          .map((e) => AttributeModel.fromJson(e))
          .toList(),
    );
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
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      values: (json['values'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      image: json['image'] ?? "",
    );
  }
}
