import 'package:flutter/material.dart';
import 'package:rrworldvision/data/model/response/review_model.dart';
import 'package:rrworldvision/helper/date_converter.dart';
import 'package:rrworldvision/provider/product_details_provider.dart';
import 'package:rrworldvision/provider/splash_provider.dart';
import 'package:rrworldvision/utill/color_resources.dart';
import 'package:rrworldvision/utill/custom_themes.dart';
import 'package:rrworldvision/utill/dimensions.dart';
import 'package:rrworldvision/utill/images.dart';
import 'package:rrworldvision/view/basewidget/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  ReviewWidget({@required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      reviewModel.customer != null
          ? Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                  image:
                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${reviewModel.customer.image}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 5),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(
                    '${reviewModel.customer.fName} ${reviewModel.customer.lName}',
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5),
                  RatingBar(rating: reviewModel.rating.toDouble(), size: 12),
                ]),
                Text(
                    DateConverter.localDateToIsoStringAMPM(
                        DateTime.parse(reviewModel.updatedAt)),
                    style: titilliumRegular.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
              ]),
            ])
          : SizedBox(),
      SizedBox(height: 5),
      Text(
        reviewModel.comment,
        style: titilliumRegular.copyWith(
            color: Theme.of(context).hintColor,
            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 5),
      reviewModel.attachment.length > 0
          ? SizedBox(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: reviewModel.attachment.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        image:
                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls.reviewImageUrl}/${reviewModel.attachment[index]}',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            )
          : SizedBox(),
    ]);
  }
}

class ReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: Provider.of<ProductDetailsProvider>(context).reviewList == null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            maxRadius: 15,
            backgroundColor: ColorResources.SELLER_TXT,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(height: 10, width: 50, color: ColorResources.WHITE),
              SizedBox(width: 5),
              RatingBar(rating: 0, size: 12),
            ]),
            Container(height: 10, width: 50, color: ColorResources.WHITE),
          ]),
        ]),
        SizedBox(height: 5),
        Container(height: 20, width: 200, color: ColorResources.WHITE),
      ]),
    );
  }
}
