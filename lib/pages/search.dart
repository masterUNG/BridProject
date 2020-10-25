import 'dart:convert';

import 'package:barcode_scanner/barcode_scanning_data.dart';
import 'package:birdqrcode/models/product_model.dart';
import 'package:birdqrcode/utility/my_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/normal_dialog.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search, stockEdit;
  ProductModel productModel;

  Widget buildTextField() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              inputFormatters: [UperCaseTextFormatter()],
              onChanged: (value) {
                search = value.trim();
                print('search leangh ==> ${search.length}');
                if (search.length == 6) {
                  FocusScope.of(context).unfocus();
                  readData();
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => qrBarCodeReader(),
          )
        ],
      );

      Future<Null> qrBarCodeReader()async{
        try {

          // var result = await BarcodeScannerConfiguration()
          
        } catch (e) {
        }
      }

  Future<Null> readData() async {
    String path =
        'http://www.scitrader.co.th/VR/app/productAPI.php?act=searchID&p_ID=$search';
    print('path ==$path');

    try {
      var response = await Dio().get(path);
      // print('res = $response');

      if (response.toString() == 'null') {
        normalDialog(context, 'ไม่มี $search ในฐานข้อมูล');
        setState(() {
          productModel = null;
        });
      } else {
        var result = json.decode(response.data);
        // print('result ==>>> $result');

        for (var json in result) {
          // print('json ====>>> $json');

          setState(() {
            productModel = ProductModel.fromJson(json);
            stockEdit = productModel.pStock;
            // print('name = ${productModel.pName}');
          });
        }
      }
    } catch (e) {
      print('Error readData ======>> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTextField(),
            productModel == null
                ? SizedBox()
                : Column(
                    children: [
                      Text(productModel.pName),
                      buildRowImage(context),
                      buildEditStock()
                    ],
                  )
          ],
        ),
      ),
    );
  }

  RaisedButton buildEditStock() {
    return RaisedButton.icon(
      onPressed: () {
        if (stockEdit == productModel.pStock) {
          normalDialog(context, 'ค่า Stock ยังไม่มีการเปลี่ยนแปลง');
        } else if (checkNumber(stockEdit)) {
          normalDialog(context, 'Stock ต้องเป็นตัวเลขเท่านั้น');
        } else {
          editStockThread();
        }
      },
      icon: Icon(Icons.edit),
      label: Text('Edit Stock'),
    );
  }

  Future<Null> editStockThread() async {
    String path =
        'http://www.scitrader.co.th/VR/app/productAPI.php?act=updateProduct&p_ID=$search&p_stock=$stockEdit';

    try {
      await Dio().get(path).then(
            (value) => normalDialog(context, 'Success Edit Stock'),
          );
    } catch (e) {
      normalDialog(context, 'Error ? กรุณาลองใหม่ ');
    }
  }

  bool checkNumber(String string) {
    print('string ==> $string');
    try {
      int i = int.parse(string);
      return false; // Number ==> 1234
    } catch (e) {
      return true; // Numbase ==> abcde
    }
  }

  Row buildRowImage(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: CachedNetworkImage(
            imageUrl: findUrlImage(),
            placeholder: (context, url) => MyStyle().showProgress(),
            errorWidget: (context, url, error) =>
                Image.asset('images/question.png'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('ราคา ${productModel.pPrice} บาท'),
              Text('หน่วย ${productModel.pUnit}'),
              TextFormField(
                onChanged: (value) {
                  stockEdit = value.trim();
                },
                keyboardType: TextInputType.number,
                key: Key(stockEdit),
                initialValue: stockEdit,
                decoration: InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String findUrlImage() {
    String group = search.substring(0, 2);
    String url = 'http://scitrader.co.th/VR/images/Product/$group/$search.jpg';
    print('url Image = $url');
    return url;
  }
}

class UperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // throw UnimplementedError();
    return TextEditingValue(
        text: newValue.text?.toUpperCase(), selection: newValue.selection);
  }
}
