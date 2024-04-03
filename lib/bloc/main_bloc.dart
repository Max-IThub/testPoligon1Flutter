import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_poligon1/bloc/main_events.dart';
import 'package:test_poligon1/bloc/main_states.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitialState()) {
    on<DeleteEvent>(_deleteEvent);
    on<NavigateToScreenEvent>(_navigateToScreenEvent);
    on<LoadingEvent>(_loadingEvent);
  }

  List<String> products = [];

  Future<void> _deleteEvent(DeleteEvent event, Emitter<MainState> emit) async {
    emit(LoadingState());
    products.removeAt(event.index);
    emit(LoadedState(listOfProducts: products));
  }

  Future<void> _navigateToScreenEvent(NavigateToScreenEvent event, Emitter<MainState> emit) async {
    final String currentProduct = products[event.index];
    emit(NavigateToScreenState(
        listOfProducts: products, product: currentProduct));
  }

  Future<void> _loadingEvent(LoadingEvent event, Emitter<MainState> emit) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 2));
    List<String> newProducts = [
      'Product 1',
      'Product 2',
      'Product 3',
      'Product 4',
      'Product 5',
    ];

    products = newProducts;

    emit(LoadedState(listOfProducts: newProducts));
  }
}
