class BankResponse {
  bool status;
  String message;
  List<BankData> bank;

  BankResponse({
    required this.status,
    required this.message,
    required this.bank,
  });

  factory BankResponse.fromJson(Map<String, dynamic> json) {
    return BankResponse(
      status: json['status'],
      message: json['message'],
      bank: (json['bank'] as List)
          .map((e) => BankData.fromJson(e))
          .toList(),
    );
  }
}

class BankData {
  String id;
  String name;
  String createdAt;
  String updatedAt;

  BankData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankData.fromJson(Map<String, dynamic> json) {
    return BankData(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
