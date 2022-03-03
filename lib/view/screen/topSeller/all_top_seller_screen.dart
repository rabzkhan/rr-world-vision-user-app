import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rrworldvision/data/model/response/top_seller_model.dart';

import 'package:rrworldvision/localization/language_constrants.dart';
import 'package:rrworldvision/provider/theme_provider.dart';
import 'package:rrworldvision/utill/color_resources.dart';
import 'package:rrworldvision/utill/custom_themes.dart';
import 'package:rrworldvision/utill/dimensions.dart';
import 'package:rrworldvision/view/screen/home/widget/top_seller_view.dart';
import 'package:provider/provider.dart';

class AllTopSellerScreen extends StatelessWidget {
  final TopSellerModel topSeller;
  AllTopSellerScreen({@required this.topSeller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, size: 20, color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(getTranslated('top_seller', context),
            style: titilliumRegular.copyWith(
                fontSize: 20, color: ColorResources.WHITE)),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: TopSellerView(isHomePage: false),
      ),
    );
  }
}
