import 'package:soqsoq/models/product.dart';
import 'package:soqsoq/models/product_repo.dart';

import '../helpers/database_helper.dart';

class ProductDbRepo extends ProductRepo{
  List<Product> allProducts = [];
  final DatabaseHelper dbhelper = DatabaseHelper.instance;
  @override
  Future<List<Product>> loadProducts() async {
    final List<Map<String, dynamic>> data =
        await dbhelper.getFromTable(tableName: 'products');
    allProducts = data.map((d) => Product.fromJson(d)).toList();
    return allProducts;
  }

}