import 'package:dio/dio.dart';
import 'package:soqsoq/models/product_api_repo.dart';
import 'package:soqsoq/models/product_db_repo.dart';
import 'package:soqsoq/models/product_repo.dart';
import '../helpers/database_helper.dart';
import '../helpers/http_helper.dart';
import '../models/product.dart';

class ProductVm {
  List<Product> allProducts = [];
  late final ProductRepo repo;

  Future<List<Product>> getProducts() async {
    if (checkConnect()) {
      try {
        repo = ProductDbRepo(); // Use API repo if connected
        return await repo.loadProducts();
      } catch (e) {
        // Fallback to local database if API call fails
        repo = ProductDbRepo();
        return await repo.loadProducts();
      }
    } else {
      // Use local database if no internet connection
      repo = ProductDbRepo();
      return await repo.loadProducts();
    }
  }

  bool checkConnect() {
    // Replace this with actual network connectivity check
    // Example: return await Connectivity().checkConnectivity() != ConnectivityResult.none;
    return true; // Placeholder for testing
  }
}
