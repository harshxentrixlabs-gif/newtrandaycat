class CategoryResponse {
  final bool status;
  final String message;
  final List<Category> category;

  CategoryResponse({
    required this.status,
    required this.message,
    required this.category,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      category: json["category"] != null
          ? List<Category>.from(
          json["category"].map((x) => Category.fromJson(x)))
          : [],
    );
  }
}

class Category {
  final String id;
  final String name;
  final String image;
  final List<SubCategory> subCategory;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.subCategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      subCategory: json["subCategory"] != null
          ? List<SubCategory>.from(
          json["subCategory"].map((x) => SubCategory.fromJson(x)))
          : [],
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      image: json["image"] ?? "",
    );
  }
}
