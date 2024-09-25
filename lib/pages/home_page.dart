import 'package:bloc_http_api_app/pages/widgets/product_card.dart';
import 'package:bloc_http_api_app/pages/widgets/product_preview.dart';
import 'package:bloc_http_api_app/product/bloc/bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ProductLoadedState) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: state.products.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final product = state.products[index];
                return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: ProductPreview(product: product),
                          );
                        },
                      );
                    },
                    child: ProductCard(
                      product: product,
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              });
        }
        if (state is ProductEmptyState) {
          return const Center(
            child: Text(
              "No data found",
              style: TextStyle(color: Colors.green),
            ),
          );
        }
        if (state is ProductLoadingFailedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.network_check_rounded,
                  color: Colors.blueAccent,
                  size: 40.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
