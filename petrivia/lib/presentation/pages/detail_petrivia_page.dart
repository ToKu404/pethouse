import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/no_internet_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPetriviaPage extends StatefulWidget {
  final PetriviaEntity petriviaEntity;
  const DetailPetriviaPage({Key? key, required this.petriviaEntity})
      : super(key: key);

  @override
  State<DetailPetriviaPage> createState() => _DetailPetriviaPageState();
}

class _DetailPetriviaPageState extends State<DetailPetriviaPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InternetCheckCubit>(context).onCheckConnectionOnetime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: const DefaultAppBar(),
      body: SafeArea(
        child: BlocBuilder<InternetCheckCubit, InternetCheckState>(
          builder: (context, state) {
            if (state is InternetCheckLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnetimeCheckGain) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.petriviaEntity.title!,
                        style: kTextTheme.subtitle1?.copyWith(fontSize: 18),
                      ),
                      Text(
                        _generateTags(widget.petriviaEntity.tags!),
                        style: kTextTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.petriviaEntity.imgUrl == "" ||
                              widget.petriviaEntity.imgUrl == null
                          ? const NoImageCard(
                              borderRadius: 10,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.petriviaEntity.imgUrl!,
                              placeholder: (context, url) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: const LoadingImageCard(
                                  borderRadius: 10,
                                ),
                              ),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              errorWidget: (context, url, error) =>
                                  const NoImageCard(
                                height: 200,
                                borderRadius: 10,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.petriviaEntity.value!,
                        textAlign: TextAlign.justify,
                        style: kTextTheme.overline
                            ?.copyWith(height: 1.2, fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              style: kTextTheme.bodyText1
                                  ?.copyWith(color: kDarkBrown),
                              children: [
                            const TextSpan(text: 'Source : '),
                            TextSpan(
                                text: widget.petriviaEntity.source!,
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    if (!await launchUrlString(
                                      widget.petriviaEntity.source!,
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw 'Could not launch ${widget.petriviaEntity.source!}';
                                    }
                                  })
                          ]))
                    ],
                  ),
                ),
              );
            } else {
              return const NoInternetPage();
            }
          },
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
