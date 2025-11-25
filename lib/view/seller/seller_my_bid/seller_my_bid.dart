import 'package:flutter/material.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../../utils/app_color.dart';

class SellerMyBid extends StatefulWidget {
  const SellerMyBid({super.key});

  @override
  State<SellerMyBid> createState() => _SellerMyBidState();
}

class _SellerMyBidState extends State<SellerMyBid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.auctionBid),
      body: Center(child: AppText("No Bid")),
    );
  }
}
