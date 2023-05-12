
import 'dart:io';

import 'package:edge_app/api/services/ecom.dart';
import 'package:flutter/cupertino.dart';

import '../models/categorymodel.dart';
import '../models/productmodel.dart';

class ProductProvider with ChangeNotifier {

  ApiCall _service = new ApiCall();
  bool isLoading = false;

  bool noNet=false;
  String _resMessage = '';



  List<ProductModel> _pros = [];
  List<ProductModel> get pros => _pros;

  List<ProductModel> _searchPro=[];
  List<ProductModel> get searchPro=> _searchPro;

  String get resMessage => _resMessage;


  Future <void> getAllProducts() async {


    try{


      isLoading = true;
      noNet=false;
      notifyListeners();
      final response = await _service.getPro();
      _pros = response!;
      isLoading = false;
      noNet=false;
      notifyListeners();


    }on SocketException catch (_) {

      isLoading= false;
      noNet=true;
      _resMessage = "Internet connection is not available`";
      notifyListeners();

    } catch (e) {

      isLoading = false;
      noNet=false;
      _resMessage = "Please try again`";
      notifyListeners();
      print(":::: $e");

    }


  }


  searchProduct({
    required String text
}) {
    _searchPro.clear();
    notifyListeners();
    if (text.isEmpty) {

    } else {
      pros.forEach((element) {
        if (element.nem.toLowerCase().contains(text)) {
          _searchPro.add(element);
          notifyListeners();
        }
      });
      notifyListeners();
    }
  }




}
