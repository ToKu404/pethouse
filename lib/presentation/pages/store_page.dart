import 'package:core/core.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        return StoreCard(store: stores[index]);
      },
    );
  }

  Future exctractData() async {
    //https://www.bukalapak.com/c/hobi-koleksi/pet-food-stuff/vitamin-obat-obatan?
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

        print(detailUrl[0]);
        print(detailUrl.length);
        setState(() {
          stores = List.generate(
              title.length,
              (index) => Store(title[index], price[index],
                  imageUrl[index] ?? '', detailUrl[index] ?? ''));
        });
      } catch (e) {
        print(e.toString());
        return [];
      }
    } else {
      print('Error');
      return [];
    }
  }
}

class Store {
  final String title;
  final String price;
  final String imgUrl;
  final String detailUrl;

  Store(this.title, this.price, this.imgUrl, this.detailUrl);
}

class StoreCard extends StatelessWidget {
  final Store store;
  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrlString(
          store.detailUrl,
          mode: LaunchMode.externalApplication,
        )) {
          throw 'Could not launch ${store.detailUrl}';
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.network(store.imgUrl),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  store.title,
                  style: kTextTheme.subtitle2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  store.price,
                  style: kTextTheme.bodyText2?.copyWith(color: kPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
