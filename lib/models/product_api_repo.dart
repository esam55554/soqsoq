import 'package:dio/dio.dart';
import 'package:soqsoq/helpers/http_helper.dart';
import 'package:soqsoq/models/product.dart';
import 'package:soqsoq/models/product_repo.dart';

class ProductApiRepo extends ProductRepo
{
  final HttpHelper? helper = HttpHelper.getInstance;
  @override
  Future<List<Product>> loadProducts() async {
    final Response rr = await helper!.getRequest(url: 'url');
    final List<Product> products = (rr.data as List)
        .map((item) => Product.fromJson(item))
        .toList();
    return products;
     }

}