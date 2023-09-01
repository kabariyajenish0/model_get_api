import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_get_api/Model/product_model.dart';

class ProductServices {
  static Future<List<ProductModel>?> getProducts() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    print("Response....${jsonDecode(response.body)}");

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
