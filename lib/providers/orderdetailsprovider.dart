
import 'package:flutter/cupertino.dart';

import '../api/services/ecom.dart';
import '../models/oderitemmodel.dart';
class MyOrdersDetailsProviders extends ChangeNotifier{

  ApiCall _service = new ApiCall();
  bool isLoading = false;


  List<OrderItemsModel> _deto = [];
  List<OrderItemsModel> get deto => _deto;


  getMYODeatil(String id)async{
    isLoading = true;
    notifyListeners();
    final response = await _service.getOderDetails(id);
    _deto = response!;
    isLoading = false;
    notifyListeners();

  }

}