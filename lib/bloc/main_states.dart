abstract class MainState {}

class InitialState extends MainState {}

class LoadingState extends MainState {}

class LoadedState extends MainState {
  LoadedState({required this.listOfProducts});
  List<String> listOfProducts;
}

class NavigateToScreenState extends LoadedState {
  String product;
  NavigateToScreenState({required super.listOfProducts, required this.product});
}
