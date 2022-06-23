import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/domain/entities/store.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

part 'store_scrapping_state.dart';

class StoreScrappingCubit extends Cubit<StoreScrappingState> {
  StoreScrappingCubit() : super(StoreScrappingInitial());

  Future<void> fetchStoreItem() async {
    emit(StoreScrappingLoading());
    final response = await http.get(Uri.parse(
        'https://www.bukalapak.com/products?search%5Bkeywords%5D=cat%20food'));
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

        final result = List.generate(
            title.length,
            (index) => Store(title[index], price[index], imageUrl[index] ?? '',
                detailUrl[index] ?? ''));
        emit(StoreScrappingSuccess(result));
      } catch (e) {
        emit(StoreScrappingError());
      }
    } else {
      emit(StoreScrappingError());
    }
  }
}
