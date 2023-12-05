import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:alcoapp_main/backend/backend.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbols.dart';
import 'package:map_launcher/map_launcher.dart';

import '../auth/auth_util.dart';
import '../components/notif_widget.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/lat_lng.dart';

List<Map> infoShops = [
  {
    'address': 'Кропоткина, 288',
    'token': 'e8d8a3f0-1d1a-8de8-e05f-e71a67cf2267',
    'id': '04e88974-aac3-47c0-ae67-a4480be65304',
  },
  {
    'address': 'Комсомольская, 2/2',
    'token': 'e8d8a3f0-1d1a-8de8-e05f-e71a67cf2267',
    'id': '5c25a380-cc48-4e0a-885b-39c738f7dc3d',
  },
  {
    'address': 'Тюленина, 16',
    'token': '912d4fcb-04da-f8f5-65e9-cf87cdf51c9f',
    'id': 'd3237c1d-7a40-42e4-8f88-f7337bfaf2b4',
  },
  {
    'address': 'Б. Богаткова, 253/4',
    'token': 'bae6dbe8-354a-0df0-cabf-bfcc79ee572d',
    'id': '7c40b7b9-fa53-4d02-ac52-1f936bbfb5bf',
  },
  {
    'address': 'Петухова, 22',
    'token': '59d3d2cd-3310-fc09-8754-55df1871d096',
    'id': '39f329ef-d6e7-4b91-b55a-35c91aa7d85c',
  },
  {
    'address': 'Б. Хмельницкого, 38',
    'token': '228ecf67-dd15-939a-2908-fc17ef5621ef',
    'id': '93307b1a-8dcd-4685-88c7-61a6859ae7d1',
  },
  {
    'address': 'Б. Хмельницкого, 6',
    'token': '228ecf67-dd15-939a-2908-fc17ef5621ef',
    'id': '0863e510-e401-423d-b4b5-ac0fab700726',
  },
];

Map nameShop = {
  '04e88974-aac3-47c0-ae67-a4480be65304': 'Кропоткина, 288',
  '5c25a380-cc48-4e0a-885b-39c738f7dc3d': 'Комсомольская, 2/2',
  'd3237c1d-7a40-42e4-8f88-f7337bfaf2b4': 'Тюленина, 16',
  '7c40b7b9-fa53-4d02-ac52-1f936bbfb5bf': 'Б. Богаткова, 253/4',
  '39f329ef-d6e7-4b91-b55a-35c91aa7d85c': 'Петухова, 22',
  '93307b1a-8dcd-4685-88c7-61a6859ae7d1': 'Б. Хмельницкого, 38',
  '0863e510-e401-423d-b4b5-ac0fab700726': 'Б. Хмельницкого, 6',
};

String baseUrl = 'https://api.kontur.ru/market';

class Product {
  final String? shopId;
  final String? productType;
  final int? code;
  final String? name;
  final String? unit;
  final String? groupId;
  final String? taxSystem;
  final String? vatRate;
  final String? sellPricePerUnit;
  final String? image;
  final int? productRest;
  final String? id;
  final bool? hide;

  const Product(
      {this.shopId,
      this.id,
      this.productType,
      this.code,
      this.name,
      this.unit,
      this.groupId,
      this.taxSystem,
      this.vatRate,
      this.image,
      this.productRest,
      this.hide,
      this.sellPricePerUnit});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        shopId: json['Shop_id']['Address'],
        id: json['id'],
        productType: json['Product_type'],
        code: json['Code'],
        name: json['Name'],
        unit: json['Unit'],
        groupId: json['Group_id']['id'],
        taxSystem: json['Tax_system'],
        vatRate: json['Vat_rate'],
        image: json['Image'],
        productRest: json['Product_rest'],
        hide: json.containsKey('Hide') ? json['Hide'] : false,
        sellPricePerUnit: json['Sell_price_per_unit']);
  }
}

class Shop {
  final int? id;
  final String? organizationId;
  final String? name;
  final String? address;

  const Shop({
    this.id,
    this.organizationId,
    this.name,
    this.address,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      organizationId: json['title'],
      name: json['country'],
      address: json['address'],
    );
  }
}

class Category {
  final String? name;
  final String? parentId;
  final String? id;
  final bool? isRelative;
  final String? image;
  final bool? hide;

  const Category({
    this.name,
    this.parentId,
    this.id,
    this.image,
    this.isRelative,
    this.hide,
  });

  factory Category.fromJson(Map<String, dynamic> json, bool isRelative) {
    return Category(
      id: json['Cat_id'],
      parentId: json['Parent_id'],
      name: json['Name'],
      image: json['Image'],
      hide: json.containsKey('Hide') ? json['Hide'] : false,
      isRelative: isRelative,
    );
  }
}

Future<String> getInfoShop(String idShop) async {
  var infoShops = await queryShopsRecordOnce();
  ShopsRecord? infoShop;

  for (var shop in infoShops) {
    if (shop.shopId == idShop) {
      infoShop = shop;
      break;
    }
  }

  return infoShop!.token!;
}

// Future<List<Product>> fetchProducts(String idShop) async {
//   String token = await getInfoShop(idShop);
//   print(token);

//   Map<String, dynamic> headers = {
//     'Content-Type': 'application/json',
//   };

//   final response = await Dio().request(
//     'https://api.directual.com/good/api/v5/data/products/GetProducts?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&pageSize=1672&Shop=04e88974-aac3-47c0-ae67-a4480be65304',
//     options: Options(method: 'GET'),
//   );

//   Map<String, dynamic> dataR = response.data as Map<String, dynamic>;

//   if (response.statusCode == 200) {
//     List<Product> products = [];
//     for (var data in dataR['payload']) {
//       Product product = Product.fromJson(data);
//       products.add(product);
//     }

//     return products;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load products');
//   }
// }

Future<List<Category>> fetchCategories(String idShop) async {
  //String token = await getInfoShop(idShop);
  //print(token);

  try {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    final response = await Dio().request(
      'https://api.directual.com/good/api/v5/data/shops/GetShopsCategories?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=7d0ce9c0-cc74-4612-83f6-e1dcc9f921b2&Shop_id=$idShop&pageSize=1000',
      options: Options(method: 'GET'),
    );

    Map<String, dynamic> dataR = response.data as Map<String, dynamic>;

    if (response.statusCode == 200) {
      List<Category> categories = [];
      for (var data in dataR['payload'][0]['All_categories_array_link']) {
        if (!data.containsKey("Parent_id")) {
          bool isRelative = false;
          for (var data1 in dataR['payload'][0]['All_categories_array_link']) {
            if (data['Cat_id'] == data1['Parent_id']) {
              isRelative = true;
              break;
            }
          }

          Category category = Category.fromJson(data, isRelative);
          categories.add(category);
        }
      }

      return categories;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load products');
    }
  } catch (e) {
    List<Category> categories = [];

    return categories;
  }
}

Future<List<Category>> fetchSubCategories(
    String idCategory, String shopId) async {
  //String token = await getInfoShop(idShop);
  //print(token);

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  final response = await Dio().request(
    'https://api.directual.com/good/api/v5/data/categories_all/GetSubCategories?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=c0f1c9a0-3159-4c9e-9945-22516b121b27&ParentCategory_id=$idCategory&pageSize=1000&Shop=$shopId',
    options: Options(method: 'GET'),
  );

  Map<String, dynamic> dataR = response.data as Map<String, dynamic>;

  if (response.statusCode == 200) {
    List<Category> categories = [];
    for (var data in dataR['payload']) {
      Category category = Category.fromJson(data, false);
      categories.add(category);
    }

    return categories;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProductsOneType(
    String idShop, String categoryId) async {
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  final response = await Dio().request(
    'https://api.directual.com/good/api/v5/data/products/GetProductsOneCategory?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=659e26b3-2903-4afd-a360-937de1ab5ceb&Shop=$idShop&Group_id=$categoryId&pageSize=1000',
    options: Options(method: 'GET'),
  );

  // try {
  String token = await getInfoShop(idShop);

  Map<String, dynamic> headersRest = {
    'Content-Type': 'application/json',
    'x-kontur-apikey': token,
  };

  final responseRest = await Dio().request(
    'https://api.kontur.ru/market/v1/shops/$idShop/product-rests',
    options: Options(method: 'GET', headers: headersRest),
  );
  // print(responseRest.data);
  // } catch (e) {
  //   if (e is DioError) {
  //     //handle DioError here by error type or by error code
  //     print(e.response);
  //   } else {
  //     print(e);
  //   }
  // }

  Map<String, dynamic> dataR = response.data as Map<String, dynamic>;

  if (response.statusCode == 200) {
    List<Product> products = [];
    for (var data in dataR['payload']) {
      // int rest = 0;
      // bool isFind = true;
      // for (var dataRest in responseRest.data['items']) {
      //   if (dataRest['productId'] == data['id']) {
      //     rest = dataRest['rest'];
      //     isFind = false;
      //     break;
      //   }
      // }

      Product product = Product.fromJson(data);
      products.add(product);
    }

    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProductsAll(String idShop) async {
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  final response = await Dio().request(
    'https://api.directual.com/good/api/v5/data/products/GetProducts?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=b8c3ee00-e637-42a1-8332-55e6f15a363f&Shop=$idShop&pageSize=3000',
    options: Options(method: 'GET'),
  );

  // String token = await getInfoShop(idShop);

  // Map<String, dynamic> headersRest = {
  //   'Content-Type': 'application/json',
  //   'x-kontur-apikey': token,
  // };

  // final responseRest = await Dio().request(
  //   'https://api.kontur.ru/market/v1/shops/$idShop/product-rests',
  //   options: Options(method: 'GET', headers: headersRest),
  // );

  Map<String, dynamic> dataR = response.data as Map<String, dynamic>;

  if (response.statusCode == 200) {
    List<Product> products = [];
    for (var data in dataR['payload']) {
      try {
        Product product = Product.fromJson(data);
        products.add(product);
      } catch (e) {
        print(e);
      }
    }

    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load products');
  }
}

Future<Map<String, dynamic>> createCard(
    int phone, String name, String surname) async {
  Map<String, dynamic> headers = {
    'x-access-token': '32dec70884d6ed49dcee9566dfb0c974',
    'Content-Type': 'application/json',
  };

  int userId;
  Map<String, dynamic> body1 = {
    "sName": name,
    "fName": surname,
    "phone": phone,
    "idTemplate": 19909
  };

  final response1 = await Dio().request(
    'https://app.boomerangme.cards/api/v1/createClient',
    data: body1,
    options: Options(method: 'POST', headers: headers),
  );
  print(jsonDecode(response1.data));
  userId = jsonDecode(response1.data)['userID'];

  Map<String, dynamic> body2 = {
    "idTemplate": 19909,
    "userID": userId,
  };

  final response2 = await Dio().request(
    'https://app.boomerangme.cards/api/v1/createPass',
    data: body2,
    options: Options(method: 'POST', headers: headers),
  );
  print(jsonDecode(response2.data));

  String serialNumber = jsonDecode(response2.data)['serialNumber'];
  String installCardLink = jsonDecode(response2.data)['installURL'];
  print(serialNumber);

  var result = {
    'serialNumber': serialNumber,
    'installCardLink': installCardLink
  };
  return result;
}

Future<String> addProductForOrder(int orderId, CartRecord product) async {
  try {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body1 = {
      "Order_id": orderId.toString(),
      "Product_id": product.productId.toString(),
      "Name": product.name.toString(),
      "Image": product.image.toString(),
      "Count": product.count.toString(),
      "Price": product.price.toString(),
    };

    final response1 = await Dio().request(
      'https://api.directual.com/good/api/v5/data/order_products/AddProductFromOrder?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=bd0ef293-d1e5-496d-82c2-d142aa2e05f7',
      data: body1,
      options: Options(method: 'POST', headers: headers),
    );

    return 'success';
  } catch (e) {
    print(e);

    return 'error';
  }
}

Future<String> addNewOrder(
    int orderId, phone, dateCreated, status, shop, summa, name, card) async {
  try {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body1 = {
      "id": orderId.toString(),
      "Customer_phone": phone.toString().substring(1),
      "Customer_name": name,
      "Date_create": dateCreated,
      "Status": status.toString(),
      "Shop": shop.toString(),
      "Sum_price": summa.toString(),
      'Customer_card': card.toString(),
    };

    final response1 = await Dio().request(
      'https://api.directual.com/good/api/v5/data/orders/AddNewOrder?appID=8f96e0a8-48e3-4b74-87e5-811c13303da7&sessionID=bd0ef293-d1e5-496d-82c2-d142aa2e05f7',
      data: body1,
      options: Options(method: 'POST', headers: headers),
    );

    return 'success';
  } catch (e) {
    print(e);
    return 'error';
  }
}

void openMap(ShopsRecord shop) async {
  final availableMaps = await MapLauncher.installedMaps;
  await availableMaps.first.showMarker(
    coords: Coords(shop.locaion!.latitude, shop.locaion!.longitude),
    title: shop.shopName!,
  );
}

int calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  double distance = 12742 * asin(sqrt(a));
  return distance.round();
}

void notif(BuildContext context, Timer timer) async {
  bool proccess = true;
  var result = await FirebaseFirestore.instance
      .collection('orders')
      .where('user', isEqualTo: currentUserReference)
      .where('datetime',
          isGreaterThan: getCurrentTimestamp.subtract(Duration(hours: 4)))
      .orderBy('datetime', descending: true)
      .get();

  for (var i in result.docs) {
    var order = i.data();
    if (order['push']) {
      proccess = false;
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: NotifWidget(
              status: order['status'],
              id: order['id'].toString(),
              shop: order['shop'],
            ),
          );
        },
      );
      final orderUpdateData = createOrdersRecordData(
        push: false,
      );
      await i.reference.update(orderUpdateData);
    }
    if (order['status'].toLowerCase() == 'завершен' ||
        order['status'].toLowerCase() == 'завершён' ||
        order['status'].toLowerCase() == 'отменен' ||
        order['status'].toLowerCase() == 'отменён') {
      timer.cancel();
    }
  }
  // if (proccess) {
  //   timer.cancel();
  // }
}

Future<String> sendFcall(String phone) async {
  // Map<String, dynamic> headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': "Bearer SATg8F1-0n_xW2Jg8ibPnSIps274yhLK",
  // };

  // Map<String, dynamic> body1 = {
  //   "jsonrpc": "2.0",
  //   "method": "flash-call/send",
  //   "params": {
  //     "phone": phone,
  //   },
  //   "id": 1
  // };

  //  final response = await Dio().request(
  //   'https://new-api.plusofon.ru',
  //   data: body1,
  //   options: Options(method: 'POST', headers: headers),
  // );
  // print(response.data);

  // var result = response.data['result'];

  // return result;

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': "Bearer 99fe21395961ee8c7bdb1d4cba3d8922",
  };

  final response = await Dio().request(
    'https://api.mcn.ru/v2/rest/account/132133/flash_call?login_did=$phone&code=4877',
    options: Options(method: 'POST', headers: headers),
  );
  print(response.data);

  // var result = response.data['result'];
  var code = response.data['object']['code'];

  return code;
}

Future<bool> verifyFcall(String verifyID, String pin) async {
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer SATg8F1-0n_xW2Jg8ibPnSIps274yhLK",
  };

  Map<String, dynamic> body1 = {
    "jsonrpc": "2.0",
    "method": "flash-call/check",
    "params": {
      "pin": pin,
      "key": verifyID,
    },
    "id": 1
  };

  final response = await Dio().request(
    'https://new-api.plusofon.ru',
    data: body1,
    options: Options(method: 'POST', headers: headers),
  );

  var result = response.data['result'];
  print(result);

  return result;
}

Future<String> getToken(String phone) async {
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> body1 = {
    "phone": phone,
  };

  final response = await Dio().request(
    'http://yomkost.pythonanywhere.com/token',
    data: body1,
    options: Options(method: 'POST', headers: headers),
  );

  var result = response.data;

  return result;
}
