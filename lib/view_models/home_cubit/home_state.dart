part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({required this.products, required this.carouselItems});

  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> products;
}

final class HomeError extends HomeState {
  HomeError({required this.message});
  final String message;
}
