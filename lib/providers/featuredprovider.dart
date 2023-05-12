import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../api/services/ecom.dart';
import '../models/productmodel.dart';

class FeaturedProvider with ChangeNotifier {

  ApiCall _service = new ApiCall();
  bool isLoading = false;
  bool noNet=false;
  String _resMessage = '';

  List<ProductModel> _fea = [];

  List<ProductModel> get fea => _fea;
  String get resMessage => _resMessage;

  Future <void> getAllFeatured() async {


    try{



      isLoading = true;
      noNet=false;
      notifyListeners();
      final response = await _service.getFeatured();
      _fea= response!;
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

}
