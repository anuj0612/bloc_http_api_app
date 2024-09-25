import 'package:bloc_http_api_app/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';
import 'dart:io';

import '../../model/product_model.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<GetProductEvent>(
        (GetProductEvent event, Emitter<ProductState> emit) async {
      emit(ProductLoadingState());
      try {
        final products = await productRepository.getProducts();
        if (products.isEmpty) {
          emit(ProductEmptyState());
        } else {
          emit(ProductLoadedState(products: products));
        }
      } catch (e, stacktrace) {
        print("error: $e \n stacktrace:=>$stacktrace");
        final message = handleExceptionWithMessage(e);
        emit(ProductLoadingFailedState(errorMessage: message));
      }
    });
  }
}

String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "It seems you are not connected to the internet.";
  } else if (error is TimeoutException) {
    return "The request timed out. Ensure you have a stable internet connection";
  } else {
    return "An error occurred, please try again";
  }
}
