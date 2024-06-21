import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer';

import '../model/productsData.dart';

class Api {
  static const baseUrl = 'http://192.168.3.101:3000/api/';
  //post method (saving data through server into db
  static void addProduct(Map pData) async {
    log('data in add Product function: ${jsonEncode(pData)}');
    final url = Uri.parse('${baseUrl}addProduct');

    try {
      final res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(pData));

      if (res.statusCode == 200) {
        Map<String, dynamic> dataGet = jsonDecode(res.body);
        log('dataGet: ${dataGet['data']}');
        // log('res.Body original: ${jsonDecode(res.body)}');
      } else {
        log('data Could\'nt be Saved');
      }
    } catch (e) {
      log('error in api Service: $e');
    }
  }

  //get method (getting data through server into db
  static getProduct() async {
    List<Products> products = [];
    final url = Uri.parse('${baseUrl}getProduct');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        data['products'].forEach((value) {
          products.add(Products(
              id: int.tryParse(value['id'].toString()),
              name: value['Name'].toString(),
              price: double.tryParse(value['Price'].toString()) ?? 0,
              desc: value['Description'].toString()));
        });
        return products;
      }
    } catch (e) {
      log('error in getProducts Api: $e');
      return [];
    }
  }

  //put method to change the whole entry on any parameter
  static updateEntry(int id, Map pData) async {
    final url = Uri.parse('${baseUrl}update/$id');
    try {
      final res = await http.put(url,
          headers: <String, String>{
            //have to send data after encoding it in  json because if any of the values or key is
            // a number then it won't accept it but jsonEncode() would convert every thing into string
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(pData));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        log('updated Data: ${data}');
      }
    } catch (e) {
      log('error in updateEntry: $e');
    }
  }

  static deleteEntry(int id) async {
    final url = Uri.parse('${baseUrl}delete/$id');
    try {
      final res = await http.delete(url);
      log('herer baby: ${res.statusCode} + ${res.body}');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        log('data after Delete: $data');
      }
    } catch (e) {}
  }
}
