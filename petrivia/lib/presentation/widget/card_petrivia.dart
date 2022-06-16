// ignore: depend_on_referenced_packages
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:petrivia/presentation/pages/detail_petrivia_page.dart';

class CardPetrivia extends StatelessWidget {
  final PetriviaEntity petriviaEntity;

  const CardPetrivia({Key? key, required this.petriviaEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => const DetailPetriviaPage(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  petriviaEntity.imgUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _generateTags(petriviaEntity.tags!),
                        style: kTextTheme.bodyText1,
                      ),
                      Text(
                        petriviaEntity.title!,
                        style: kTextTheme.subtitle1,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              )
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
