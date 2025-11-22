import 'package:soqsoq/models/product.dart';

abstract class ProductRepo
{
  Future<List<Product>> loadProducts();
}