import 'package:core/core.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:store/presentations/widget/store_item_card.dart';

import '../../domain/entities/store.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Store> stores = [];
  @override
  void initState() {
    super.initState();
    exctractData();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: kPadding * 2, vertical: kPadding),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return StoreItemCard(store: stores[index]);
      },
    );
  }

  Future exctractData() async {
    final response = await http.get(Uri.parse(
        'https://www.bukalapak.com/products?search%5Bkeywords%5D=whiskas'));
    if (response.statusCode == 200) {
      dom.Document document = dom.Document.html(response.body);
      try {
        final title = document
            .querySelectorAll(
                'div.bl-product-card__description > div.bl-product-card__description-name > p > a')
            .map((e) => e.innerHtml.trim())
            .toList();

        final price = document
            .querySelectorAll(
                'div.bl-product-card__description > div.bl-product-card__description-price > p')
            .map((e) => e.innerHtml.trim())
            .toList();

        final imageUrl = document
            .querySelectorAll('.bl-product-card__thumbnail figure img')
            .map((e) => e.attributes['src'])
            .toList();

        final detailUrl = document
            .querySelectorAll('.bl-product-card__thumbnail figure a')
            .map((e) => e.attributes['href'])
            .toList();
        setState(() {
          stores = List.generate(
              title.length,
              (index) => Store(title[index], price[index],
                  imageUrl[index] ?? '', detailUrl[index] ?? ''));
        });
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }
}
