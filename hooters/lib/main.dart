import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooters/services/api.dart';

import 'model/productsData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Testing Express JS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: 'name',
              ),
            ),
            TextFormField(
              controller: price,
              decoration: InputDecoration(
                hintText: 'price',
              ),
            ),
            TextFormField(
              controller: desc,
              decoration: InputDecoration(
                hintText: 'desc',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> dataToSend = {
                    "name": name.text,
                    "price": double.tryParse(price.text) ?? 0,
                    "desc": desc.text,
                  };
                  Api.addProduct(dataToSend);
                },
                child: Text('Send.')),
            PopScope(
              child: Text('press me'),
              canPop: false,
            ),
            ElevatedButton(
                onPressed: () async {
                  List<Products> products = await Api.getProduct() ?? [];
                  products.forEach((val) {
                    log('ID: ${val.id}');
                    log('Name: ${val.name}');
                    log('Price: ${val.price}');
                    log('Description: ${val.desc}');
                    log('-------------------------');
                  });
                },
                child: Text('get Data')),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> dataToSend = {
                    "name": 'yo yo honey singh',
                    "price": 9010,
                    "desc": 'baby doll masony di',
                  };
                  await Api.updateEntry(2, dataToSend);
                },
                child: Text('update Product')),
            ElevatedButton(
                onPressed: () async {
                  await Api.deleteEntry(1);
                },
                child: Text('Delete Product')),
          ],
        ),
      ),
    );
  }
}
