part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetBannersEvent extends HomeEvent{

  const GetBannersEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends HomeEvent{

  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends HomeEvent{

  const GetProductsEvent();

  @override
  List<Object> get props => [];
}
