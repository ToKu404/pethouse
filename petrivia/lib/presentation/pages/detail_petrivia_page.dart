import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPetriviaPage extends StatelessWidget {
  final PetriviaEntity petriviaEntity;
  const DetailPetriviaPage({Key? key, required this.petriviaEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                petriviaEntity.title!,
                style: kTextTheme.subtitle1?.copyWith(fontSize: 18),
              ),
              Text(
                _generateTags(petriviaEntity.tags!),
                style: kTextTheme.bodyText1,
              ),
              const SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                imageUrl: petriviaEntity.imgUrl!,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: kGrey,
                    child: const Center(child: Icon(Icons.image)),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                petriviaEntity.value!,
                textAlign: TextAlign.justify,
                style: kTextTheme.overline?.copyWith(height: 1.2, fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      style: kTextTheme.bodyText1?.copyWith(color: kDarkBrown),
                      children: [
                    const TextSpan(text: 'Source : '),
                    TextSpan(
                        text: petriviaEntity.source!,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (!await launchUrlString(
                              petriviaEntity.source!,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw 'Could not launch ${petriviaEntity.source!}';
                            }
                          })
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  _generateTags(List<String> tags) {
    String tag = '';
    for (var i = 0; i < tags.length; i++) {
      tag += tags[i].toUpperCase();
      if (i < tags.length - 1) {
        tag += ' • ';
      }
    }
    return tag;
  }
}
