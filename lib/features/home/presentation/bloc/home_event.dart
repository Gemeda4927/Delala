abstract class HomeEvent {
  const HomeEvent();
}

class FetchProductsEvent extends HomeEvent {}

class FetchCategoriesEvent extends HomeEvent {}
class FetchUsersEvent extends HomeEvent {}