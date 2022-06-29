import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:store/presentations/widget/store_item_card.dart';
import 'package:store/store.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoreScrappingCubit>(context).fetchStoreItem();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreScrappingCubit, StoreScrappingState>(
        builder: ((context, state) {
      if (state is StoreScrappingLoading) {
        return const LoadingView();
      } else if (state is StoreScrappingSuccess) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: kPadding * 2, vertical: kPadding),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return StoreItemCard(store: state.listStore[index]);
          },
        );
      } else if (state is StoreScrappingError) {
        return const ErrorView(message: 'Error Scrap Web');
      } else {
        return Container();
      }
    }));
  }
}
