class FavoriteResponse {
  bool? status;
  String? message;
  List<FavoriteProduct> favorite;

  FavoriteResponse({
    this.status,
    this.message,
    required this.favorite,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      status: json['status'],
      message: json['message'],
      favorite: (json['favorite'] as List)
          .map((e) => FavoriteProduct.fromJson(e))
          .toList(),
    );
  }
}

class FavoriteProduct {
  String? id;
  String? userId;
  String? productId;
  String? categoryId;
  List<ProductDetail> product;

  FavoriteProduct({
    this.id,
    this.userId,
    this.productId,
    this.categoryId,
    required this.product,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['_id'],
      userId: json['userId'],
      productId: json['productId'],
      categoryId: json['categoryId'],
      product: (json['product'] as List)
          .map((e) => ProductDetail.fromJson(e))
          .toList(),
    );
  }
}
class ProductDetail {
  String? id;
  int? price;
  String? productName;
  String? mainImage;
  String? category;
  String? subCategory;

  ProductDetail({
    this.id,
    this.price,
    this.productName,
    this.mainImage,
    this.category,
    this.subCategory,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['_id'],
      price: json['price'],
      productName: json['productName'],
      mainImage: json['mainImage'],
      category: json['category'],
      subCategory: json['subCategory'],
    );
  }
}
