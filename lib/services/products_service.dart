import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-78524-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  late Product selectedProduct; // Cuando lo vayamos a utilizar ya debe de tener un valor (late)

  ProductsService() {
    loadProducts();
  }

  
  Future<List<Product>> loadProducts() async {

    isLoading = true; 
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(Product product)async{
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      // Es Necesario crear
      await createProduct(product);
    }else{
      // Es necesario actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct( Product product)async{
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toRawJson());
    final decodeData =  Product.fromRawJson(resp.body);
    decodeData.id = product.id;
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = decodeData;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toRawJson());
    final decodeData = json.decode(resp.body);
    product.id = decodeData['name'];
    products.add(product);
    
    return product.id!;
  }
}
