import 'package:flutter/material.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';

class SellerMyBid extends StatefulWidget {
  const SellerMyBid({super.key});

  @override
  State<SellerMyBid> createState() => _SellerMyBidState();
}

class _SellerMyBidState extends State<SellerMyBid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Auction Bid"),
      body: Center(child: AppText("No Bid")),
    );
  }
}
