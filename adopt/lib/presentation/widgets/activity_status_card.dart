import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ActivityStatusCard extends StatelessWidget {
  final AdoptEntity adopt;
  const ActivityStatusCard({Key? key, required this.adopt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DETAIL_ADOPT_ROUTE_NAME,
          arguments: adopt.adoptId),
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ],
        ),
        child: _buildTopSide(context),
      ),
    );
  }

  Widget _buildTopSide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: adopt.petPictureUrl != null && adopt.petPictureUrl != ''
                ? Image.network(
                    adopt.petPictureUrl!,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  )
                : Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: kGrey,
                    ),
                    child: const Icon(Icons.image),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adopt.petName ?? '-',
                  style: kTextTheme.subtitle1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  adopt.petTypeText ?? '-',
                  style: kTextTheme.bodyText1?.copyWith(height: 1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
