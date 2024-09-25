import 'dart:convert';

import 'package:bloc_http_api_app/data/data_provide.dart';
import 'package:bloc_http_api_app/model/product_model.dart';

class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<List<Product>> getProducts() async {
    try {
      final response = await DataProvider.getRequest(
        endpoint:
            "https://run.mocky.io/v3/8bd9aca5-43c4-427c-b652-21016c0fff8e",
      );

      if (response.statusCode == 200) {
        // Handle potential parsing errors gracefully
        try {
          final parsedData = json.decode(response.body);
          final productList = ProductModel.fromJson(parsedData).products;
          return productList;
        } on FormatException catch (e) {
          print("Error parsing JSON response: $e");
          rethrow; // Rethrow to propagate the error
        }
      } else {
        throw Exception(
            "Error loading products: Status code ${response.statusCode}"); // More specific error message
      }
    } catch (e) {
      print("Unexpected error fetching products: $e");
      rethrow; // Rethrow to allow upper layers to handle the error
    }
  }
}
