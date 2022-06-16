import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user/data/models/about.dart';

class AboutPage extends StatelessWidget {
  final DataAppModel dataAppModel = DataAppModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AboutPage'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(dataAppModel.logo)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(dataAppModel.title,
                    style: kTextTheme.headline5?.copyWith(color: kPrimaryColor)),
                SizedBox(
                  height: 20,
                ),
                Text('Deskripsi',style: kTextTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: kDarkBrown),),
                SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.description,textAlign: TextAlign.justify,style: kTextTheme.bodyText2),
                SizedBox(
                  height: 20,
                ),
                Text('Bahasa Pemrograman',style: kTextTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: kDarkBrown),),
                SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.programming_leng,style: kTextTheme.bodyText2),
                SizedBox(
                  height: 20,
                ),
                Text('Framework',style: kTextTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: kDarkBrown),),
                SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.framework,style: kTextTheme.bodyText2),
                SizedBox(
                  height: 20,
                ),
                Text('Database',style: kTextTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: kDarkBrown),),
                SizedBox(
                  height: 5,
                ),
                Text(dataAppModel.database,style: kTextTheme.bodyText2),
                SizedBox(
                  height: 20,
                ),
                Text('Package/Depedencies',style: kTextTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: kDarkBrown),),
                SizedBox(
                  height: 5,
                ),
                // ListView.separated(
                //   itemCount: dataPackagesList.length,
                //   itemBuilder: (context, index) {
                //     final DataPackages dataPackages = dataPackagesList[index];
                //     return ListTile(
                //       title: Text(dataPackages.name),
                //       subtitle: Text(dataPackages.link),
                //       trailing: Text(dataPackages.version),
                //     );
                //   },
                //   separatorBuilder: (context,index) => const Divider(color: kGreyTransparant,),
                // ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
