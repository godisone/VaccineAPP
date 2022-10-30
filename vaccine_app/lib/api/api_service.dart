import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vaccine_app/models/product.dart';
import 'package:vaccine_app/models/product_filter.dart';
import 'package:vaccine_app/utils/shared_service.dart';
import '../config.dart';
import '../constants.dart';
import '../main.dart';
import '../models/cart.dart';
import '../models/category.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString()
    };

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }

    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
      String fullName, String email, String password) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"fullName": fullName, "email": email, "password": password},
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.productAPI + "/" + productId);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Cart.fromJson(data["data"]);
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({
          "products": [
            {"product": productId, "qty": qty}
          ]
        }));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.delete(url,
        headers: requestHeaders,
        body: jsonEncode({"productId": productId, "qty": qty}));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  static ImagePicker _imagepicker = ImagePicker();
  static RxString picture = "".obs;
  static RxList idList = [].obs;

  static pickimagefromgallery() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
      return;
    }
    final pickedFile = await _imagepicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile == null) {
      print('user cancelled the image selection');
      return;
    } else {
      uploadImage(File(pickedFile.path));
    }
  }

  static uploadImage(File image) async {
    var request =
        http.MultipartRequest(Constants().post, Uri.parse(Constants().posturl));
    request.headers["Authorization"] = Constants().clientID;
    var file = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );
    request.files.add(file);
    var response = await request.send();
    var result = await http.Response.fromStream(response)
        .then((value) => jsonDecode(value.body));
    var data = result["data"];
    idList.add(data["id"]);
    print(data);
  }

  static getImage(int index) async {
    // url of images saved on imgur is based on their IDs i.e. imgur's url + image id + .jpeg
    var newurl = Constants().baseurl + idList[index] + Constants().ext;
    picture.value = newurl;
    print(picture);
    // var request = await http.get(Uri.parse(newurl));
    // var result = jsonDecode(request.body);
    // var data = request.body;
  }
}
