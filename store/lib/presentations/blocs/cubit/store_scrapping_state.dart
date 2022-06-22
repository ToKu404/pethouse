part of 'store_scrapping_cubit.dart';

abstract class StoreScrappingState extends Equatable {
  StoreScrappingState();
  @override
  List<Object> get props => [];
}

class StoreScrappingInitial extends StoreScrappingState {}

class StoreScrappingLoading extends StoreScrappingState {}

class StoreScrappingSuccess extends StoreScrappingState {
  final List<Store> listStore;

  StoreScrappingSuccess(this.listStore);

  @override
  List<Object> get props => [listStore];
}

class StoreScrappingError extends StoreScrappingState {}
