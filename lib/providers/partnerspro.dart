
import 'package:edge_app/api/services/ecom.dart';
import 'package:flutter/cupertino.dart';

import '../models/partnermodel.dart';


class PartnersProvider with ChangeNotifier{

  ApiCall _service=new  ApiCall();
  bool isLoading=false;
  List<PartnersModel> _parts=[];
  List<PartnersModel> get parts =>_parts;


  Future <void> getAllPartners() async{
    isLoading=true;
    notifyListeners();
    final response=await _service.getPart();
    _parts=response!;
    isLoading=false;
    notifyListeners();

  }


}