import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:user/data/models/about.dart';
import 'package:user/presentation/widgets/card_about_content.dart';

class AboutPage extends StatelessWidget {
  final DataAppModel dataAppModel = DataAppModel();

  AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
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
                  'Latar Belakang',
                  style: kTextTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold, color: kDarkBrown),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.background,
                    textAlign: TextAlign.justify, style: kTextTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Apa itu Pethouse?',
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
                Row(
                  children: [
                    Expanded(
                      child: CardAboutContent(
                          subjek: 'Bahasa', contentSubjek: dataAppModel.programming_leng
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: CardAboutContent(subjek: 'Framework', contentSubjek: dataAppModel.framework)),
                    const SizedBox(width: 5),
                    Expanded(child: CardAboutContent(subjek: 'Database', contentSubjek: dataAppModel.database)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 10,
                  color: kDarkBrown,
                ),
                ListTile(
                  title: Text(
                    'Packages',
                    style: kTextTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: kDarkBrown),
                  ),
                  trailing: Text(
                    'Version',
                    style: kTextTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: kDarkBrown),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: dataPackagesList.length,
                    itemBuilder: (context, index) {
                      final DataPackages dataPackages = dataPackagesList[index];
                      return ListTile(
                        title: Text(dataPackages.name,style: kTextTheme.bodyText2),
                        subtitle: HyperlinkText(dataPackages.link),
                        dense: true,
                        trailing: Text(dataPackages.version,style: kTextTheme.bodyText2),
                      );
                    }),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 10,
                  color: kDarkBrown,
                ),
                ListTile(
                  title: Text(
                    'Assets',
                    style: kTextTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: kDarkBrown),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: dataAssetsList.length,
                    itemBuilder: (context, index) {
                      final DataAssets dataAssets = dataAssetsList[index];
                      return ListTile(
                        title: Text(dataAssets.name,style: kTextTheme.bodyText2),
                        subtitle: HyperlinkText(dataAssets.link),
                        dense: true,
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
  const HyperlinkText(this.text);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = (){
                launchUrlString(text);
                }
        ));
  }
}
