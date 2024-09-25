import 'package:bloc_http_api_app/pages/home_page.dart';
import 'package:bloc_http_api_app/product/bloc/bloc.dart';
import 'package:bloc_http_api_app/repository/product_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC api demo',
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data:
              mediaQueryData.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepository(),
        child: BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              ProductBloc(productRepository: ProductRepository()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
