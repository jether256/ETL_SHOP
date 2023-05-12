


import 'package:edge_app/models/notimodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/services/ecom.dart';
import '../models/oderitemmodel.dart';
import '../models/odermodel.dart';

class MyOrdersProviders extends ChangeNotifier{

  ApiCall _service = new ApiCall();
  bool isLoading = false;



  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;


  List<NotificationModel> _noti = [];
  List<NotificationModel> get noti => _noti;

  var _count;
  get count => _count;

  Map<String,dynamic>? _update;
  Map<String,dynamic> get update =>_update!;





  getMyOrders()async{
    orders.clear();
    isLoading = true;
    notifyListeners();
    final response = await _service.getOder();
    _orders = response!;
    isLoading = false;
    notifyListeners();

  }

  //refresh orders
refreshOrders(){
    getMyOrders();
    notifyListeners();
}

  ///order notifications count
  getOrderNotiCount() async{

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    if(ID != null){
      final response= await _service.getNotiCount();
      _count=response;
      notifyListeners();

    }else{
      _count=0;
      notifyListeners();
    }


  }


  ///get all order notifications
   getNoti()async {
    _noti.clear();
    //isLoading=true;
    notifyListeners();
    final response= await _service.getAllNotiii();
    _noti=response!;
    notifyListeners();

  }




  ///update quantity
  updateNoti({
    required String notid,
    required BuildContext context,
  }) async{
    // isLoading = true;
    // notifyListeners();
    final response = await _service.updateNotifications(notid,context);
    _update=response;
    notifyListeners();

    getNoti();
    notifyListeners();

    // isLoading=false;
    // notifyListeners();

    getOrderNotiCount();
    notifyListeners();

  }



}