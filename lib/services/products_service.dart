import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-78524-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct; // Cuando lo vayamos a utilizar ya debe de tener un valor (late)
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  final _storage = const FlutterSecureStorage();

  ProductsService() {
    loadProducts();
  }

  
  Future<List<Product>> loadProducts() async {

    isLoading = true; 
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json',{
      'auth': await _storage.read(key: 'token') ?? ''
    });
    
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
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',{
      'auth': await _storage.read(key: 'token') ?? ''
    });
    final resp = await http.put(url, body: product.toRawJson());
    final decodeData =  Product.fromRawJson(resp.body);
    decodeData.id = product.id;
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = decodeData;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',{
      'auth': await _storage.read(key: 'token') ?? ''
    });
    final resp = await http.post(url, body: product.toRawJson());
    final decodeData = json.decode(resp.body);
    product.id = decodeData['name'];
    products.add(product);
    
    return product.id!;
  }

  void updateSelectedProductImage(String path){
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage()async{
    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1//image/upload?upload_preset=sxcjvl7k');

    // Creamos la petición
    final imageUploadRequest = http.MultipartRequest('POST',url);
    // Creamos el archivo a subir
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    // Adjuntamos el archivo a la petición
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
  
    newPictureFile = null; // Limpiar la imagen 
  
    final decodeData = json.decode(response.body);
    return decodeData['secure_url'];
  

  }

}
