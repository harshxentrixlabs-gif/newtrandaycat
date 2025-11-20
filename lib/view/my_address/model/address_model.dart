class AddressModel {
  bool? status;
  String? message;
  List<Address>? address;

  AddressModel({this.status, this.message, this.address});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? sId;
  bool? isSelect;
  UserId? userId;
  String? name;
  String? country;
  String? state;
  String? city;
  int? zipCode;
  String? address;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.sId,
        this.isSelect,
        this.userId,
        this.name,
        this.country,
        this.state,
        this.city,
        this.zipCode,
        this.address,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isSelect = json['isSelect'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    name = json['name'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zipCode'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isSelect'] = this.isSelect;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['name'] = this.name;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipCode'] = this.zipCode;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;
  String? lastName;

  UserId({this.sId, this.firstName, this.lastName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}