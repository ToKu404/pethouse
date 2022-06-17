import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/data/models/about.dart';

class AboutPage extends StatelessWidget {
  final DataAppModel dataAppModel = DataAppModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AboutPage'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimaryColor),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(dataAppModel.logo)),
                    ),
                    const SizedBox(width: 20),
                    Text(dataAppModel.title,
                        style: kTextTheme.headline5
                            ?.copyWith(color: kPrimaryColor, fontSize: 32)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Deskripsi',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.description,
                    textAlign: TextAlign.justify, style: kTextTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Bahasa Pemrograman',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.programming_leng,
                    style: kTextTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Framework',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.framework, style: kTextTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Database',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.database, style: kTextTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Package/Depedencies',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: dataPackagesList.length,
                    itemBuilder: (context, index) {
                      final DataPackages dataPackages = dataPackagesList[index];
                      return ListTile(
                        title: Text(dataPackages.name),
                        subtitle: HyperlinkText(dataPackages.link),
                        dense: true,
                        trailing: Text(dataPackages.version),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Assets',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: dataAssetsList.length,
                    itemBuilder: (context, index) {
                      final DataAssets dataAssets = dataAssetsList[index];
                      return ListTile(
                        title: Text(dataAssets.name),
                        subtitle: HyperlinkText(dataAssets.link),                        dense: true,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HyperlinkText extends StatelessWidget {
  final String text;
  HyperlinkText(this.text);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = (){
                launch(text);
                }
        ));
  }
}
