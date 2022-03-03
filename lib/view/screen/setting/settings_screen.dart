import 'package:flutter/material.dart';

import 'package:rrworldvision/localization/language_constrants.dart';
import 'package:rrworldvision/provider/splash_provider.dart';
import 'package:rrworldvision/provider/theme_provider.dart';
import 'package:rrworldvision/utill/color_resources.dart';
import 'package:rrworldvision/utill/custom_themes.dart';
import 'package:rrworldvision/utill/dimensions.dart';
import 'package:rrworldvision/utill/images.dart';
import 'package:rrworldvision/view/basewidget/custom_expanded_app_bar.dart';
import 'package:rrworldvision/view/basewidget/animated_custom_dialog.dart';
import 'package:rrworldvision/view/screen/setting/widget/currency_dialog.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return WillPopScope(
      onWillPop: () {
        Provider.of<SplashProvider>(context, listen: false)
            .setFromSetting(false);
        return Future.value(true);
      },
      child: CustomExpandedAppBar(
          title: getTranslated('settings', context),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_LARGE,
                  left: Dimensions.PADDING_SIZE_LARGE),
              child: Text(getTranslated('settings', context),
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            Expanded(
                child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              children: [
                SwitchListTile(
                  value: Provider.of<ThemeProvider>(context).darkTheme,
                  onChanged: (bool isActive) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                  title: Text(getTranslated('dark_theme', context),
                      style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                TitleButton(
                  image: Images.language,
                  title: getTranslated('choose_language', context),
                  onTap: () => showAnimatedDialog(
                      context, CurrencyDialog(isCurrency: false)),
                ),
                TitleButton(
                  image: Images.currency,
                  title:
                      '${getTranslated('currency', context)} (${Provider.of<SplashProvider>(context).myCurrency.name})',
                  onTap: () => showAnimatedDialog(context, CurrencyDialog()),
                ),
                /*TitleButton(
                image: Images.preference,
                title: Strings.preference,
                onTap: () => showAnimatedDialog(context, PreferenceDialog()),
              ),*/
              ],
            )),
          ])),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  TitleButton(
      {@required this.image, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}