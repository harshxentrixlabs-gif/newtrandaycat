class FavoriteResponse {
  final bool status;
  final String message;
  final List<FavoriteItem> favorite;

  FavoriteResponse({
    required this.status,
    required this.message,
    required this.favorite,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
      favorite: (json["favorite"] as List<dynamic>? ?? [])
          .map((e) => FavoriteItem.fromJson(e))
          .toList(),
    );
  }
}

class FavoriteItem {
  final String id;
  final String userId;
  final String productId;
  final String categoryId;
  final List<ProductMini> product;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.categoryId,
    required this.product,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json["_id"] ?? "",
      userId: json["userId"] ?? "",
      productId: json["productId"] ?? "",
      categoryId: json["categoryId"] ?? "",
      product: (json["product"] as List<dynamic>? ?? [])
          .map((e) => ProductMini.fromJson(e))
          .toList(),
    );
  }
}


class ProductMini {
  final String id;
  final String productName;
  final num price;
  final bool enableAuction;
  final String? auctionEndDate;
  final String mainImage;
  final String category;
  final String subCategory;
  final String description;

  ProductMini({
    required this.id,
    required this.productName,
    required this.price,
    required this.enableAuction,
    required this.auctionEndDate,
    required this.mainImage,
    required this.category,
    required this.subCategory,
    required this.description
  });

  factory ProductMini.fromJson(Map<String, dynamic> json) {
    return ProductMini(
      id: json["_id"] ?? "",
      productName: json["productName"] ?? "",
      price: json["price"] ?? 0,
      enableAuction: json["enableAuction"] ?? false,
      auctionEndDate: json["auctionEndDate"],
      mainImage: json["mainImage"] ?? "",
      category: json["category"] ?? "",
      subCategory: json["subCategory"] ?? "",
      description: json["description"] ?? "",
    );
  }
}

