import 'package:flutter/cupertino.dart';

import '../api/services/ecom.dart';
import '../models/productmodel.dart';

class SubCatProductProvider with ChangeNotifier {

  ApiCall _service = new ApiCall();
  bool isLoading = false;
  List<ProductModel> _subpros = [];

  List<ProductModel> get subpros => _subpros;


  Future <void> getAllSubProducts(String Sbid) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getSubCatPro(Sbid);
    _subpros = response!;
    isLoading = false;
    notifyListeners();
  }

}
