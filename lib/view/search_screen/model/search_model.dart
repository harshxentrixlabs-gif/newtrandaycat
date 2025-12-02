class SearchProductsResponse {
  final bool? status;
  final String? message;
  final Products? products;

  SearchProductsResponse({this.status, this.message, this.products});

  factory SearchProductsResponse.fromJson(Map<String, dynamic> json) {
    return SearchProductsResponse(
      status: json['status'],
      message: json['message'],
      products: json['products'] != null
          ? Products.fromJson(json['products'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'products': products?.toJson(),
    };
  }
}

class Products {
  final List<Product>? lastSearchedProducts;
  final List<Product>? popularSearchedProducts;

  Products({this.lastSearchedProducts, this.popularSearchedProducts});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      lastSearchedProducts: json['lastSearchedProducts'] != null
          ? List<Product>.from(json['lastSearchedProducts']
          .map((e) => Product.fromJson(e)))
          : [],
      popularSearchedProducts: json['popularSearchedProducts'] != null
          ? List<Product>.from(json['popularSearchedProducts']
          .map((e) => Product.fromJson(e)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastSearchedProducts':
      lastSearchedProducts?.map((e) => e.toJson()).toList(),
      'popularSearchedProducts':
      popularSearchedProducts?.map((e) => e.toJson()).toList(),
    };
  }
}

class Product {
  final String? id;
  final String? productName;
  final String? productCode;
  final String? description;
  final bool? allowOffer;
  final int? minimumOfferPrice;
  final int? price;
  final int? shippingCharges;
  final bool? enableAuction;
  final String? scheduleTime;
  final int? auctionStartingPrice;
  final bool? enableReservePrice;
  final int? reservePrice;
  final int? auctionDuration;
  final String? auctionStartDate;
  final String? auctionEndDate;
  final String? processingTime;
  final String? recipientAddress;
  final bool? isImmediatePaymentRequired;
  final String? mainImage;
  final List<String>? images;
  final int? quantity;
  final int? review;
  final int? sold;
  final int? searchCount;
  final String? lastSearchedAt;
  final bool? isOutOfStock;
  final bool? isNewCollection;
  final bool? isSelect;
  final bool? isAddByAdmin;
  final bool? isUpdateByAdmin;
  final String? seller;
  final String? category;
  final String? subCategory;
  final String? createStatus;
  final String? updateStatus;
  final String? date;
  final String? createdAt;
  final String? updatedAt;

  Product({
    this.id,
    this.productName,
    this.productCode,
    this.description,
    this.allowOffer,
    this.minimumOfferPrice,
    this.price,
    this.shippingCharges,
    this.enableAuction,
    this.scheduleTime,
    this.auctionStartingPrice,
    this.enableReservePrice,
    this.reservePrice,
    this.auctionDuration,
    this.auctionStartDate,
    this.auctionEndDate,
    this.processingTime,
    this.recipientAddress,
    this.isImmediatePaymentRequired,
    this.mainImage,
    this.images,
    this.quantity,
    this.review,
    this.sold,
    this.searchCount,
    this.lastSearchedAt,
    this.isOutOfStock,
    this.isNewCollection,
    this.isSelect,
    this.isAddByAdmin,
    this.isUpdateByAdmin,
    this.seller,
    this.category,
    this.subCategory,
    this.createStatus,
    this.updateStatus,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['productName'],
      productCode: json['productCode'],
      description: json['description'],
      allowOffer: json['allowOffer'],
      minimumOfferPrice: json['minimumOfferPrice'],
      price: json['price'],
      shippingCharges: json['shippingCharges'],
      enableAuction: json['enableAuction'],
      scheduleTime: json['scheduleTime'],
      auctionStartingPrice: json['auctionStartingPrice'],
      enableReservePrice: json['enableReservePrice'],
      reservePrice: json['reservePrice'],
      auctionDuration: json['auctionDuration'],
      auctionStartDate: json['auctionStartDate'],
      auctionEndDate: json['auctionEndDate'],
      processingTime: json['processingTime'],
      recipientAddress: json['recipientAddress'],
      isImmediatePaymentRequired: json['isImmediatePaymentRequired'],
      mainImage: json['mainImage'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      quantity: json['quantity'],
      review: json['review'],
      sold: json['sold'],
      searchCount: json['searchCount'],
      lastSearchedAt: json['lastSearchedAt'],
      isOutOfStock: json['isOutOfStock'],
      isNewCollection: json['isNewCollection'],
      isSelect: json['isSelect'],
      isAddByAdmin: json['isAddByAdmin'],
      isUpdateByAdmin: json['isUpdateByAdmin'],
      seller: json['seller'],
      category: json['category'],
      subCategory: json['subCategory'],
      createStatus: json['createStatus'],
      updateStatus: json['updateStatus'],
      date: json['date'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'productCode': productCode,
      'description': description,
      'allowOffer': allowOffer,
      'minimumOfferPrice': minimumOfferPrice,
      'price': price,
      'shippingCharges': shippingCharges,
      'enableAuction': enableAuction,
      'scheduleTime': scheduleTime,
      'auctionStartingPrice': auctionStartingPrice,
      'enableReservePrice': enableReservePrice,
      'reservePrice': reservePrice,
      'auctionDuration': auctionDuration,
      'auctionStartDate': auctionStartDate,
      'auctionEndDate': auctionEndDate,
      'processingTime': processingTime,
      'recipientAddress': recipientAddress,
      'isImmediatePaymentRequired': isImmediatePaymentRequired,
      'mainImage': mainImage,
      'images': images,
      'quantity': quantity,
      'review': review,
      'sold': sold,
      'searchCount': searchCount,
      'lastSearchedAt': lastSearchedAt,
      'isOutOfStock': isOutOfStock,
      'isNewCollection': isNewCollection,
      'isSelect': isSelect,
      'isAddByAdmin': isAddByAdmin,
      'isUpdateByAdmin': isUpdateByAdmin,
      'seller': seller,
      'category': category,
      'subCategory': subCategory,
      'createStatus': createStatus,
      'updateStatus': updateStatus,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
