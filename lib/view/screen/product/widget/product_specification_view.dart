import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rrworldvision/localization/language_constrants.dart';
import 'package:rrworldvision/utill/dimensions.dart';
import 'package:rrworldvision/view/basewidget/title_row.dart';
import 'package:rrworldvision/view/screen/product/specification_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({@required this.productSpecification});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Column(
      children: [
        TitleRow(
            title: getTranslated('specification', context),
            isDetailsPage: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SpecificationScreen(
                          specification: productSpecification)));
            }),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        /*Text(
          productSpecification,
          style: titilliumRegular,
          textAlign: TextAlign.justify,
          maxLines: Provider.of<ProductDetailsProvider>(context).isDescriptionExpanded ? null : 2,
          overflow: Provider.of<ProductDetailsProvider>(context).isDescriptionExpanded ? null :TextOverflow.ellipsis,
        ),*/
        productSpecification.isNotEmpty
            ? SizedBox(
                height: 100,
                child: Html(data: productSpecification),
              )
            : Center(child: Text('No specification')),
      ],
    );
  }
}
