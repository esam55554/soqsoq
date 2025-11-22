import 'package:flutter/material.dart';
import 'package:soqsoq/core/views/widgets/products_listview.dart';
import 'package:soqsoq/view_models/productVM.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductVm? productVm;

  @override
  void initState() {
    super.initState();
    productVm = ProductVm(); // Initialize the ViewModel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: productVm?.getProducts(), // Use null-aware operator
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ProductListWidget(products: snapshot.data!);
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
