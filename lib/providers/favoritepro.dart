import 'package:flutter/cupertino.dart';

import '../api/services/ecom.dart';
import '../models/favmodel.dart';

class FavouriteProvider extends ChangeNotifier{


  ApiCall _service = new ApiCall();
  bool isLoading = false;


  Map<String,dynamic>? _add;
  Map<String,dynamic> get data =>_add!;

  Map<String,dynamic>? _del;
  Map<String,dynamic> get del =>_del!;

  List<FavoriteModel> _fav = [];
  List<FavoriteModel> get fav => _fav;


  ///add to favourite
  AddFav({
    required String id,
    required String selp,
    required String regp,
    required String promoid,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.addToFav(id,selp,regp,promoid,context);
    _add=response;
    notifyListeners();

    isLoading=false;
    notifyListeners();
  }


  ///get all favorite products
   getAllFav()async {
    isLoading=true;
    notifyListeners();
    final response= await _service.getFav();
    _fav=response!;
    notifyListeners();

  }


  refresh(){

    getAllFav();
  }


  ///delete from favorite
  deleteFavItem({
    required String catid,
    required BuildContext context,
  }) async{

    final response = await _service.delFav(catid,context);
    _del=response;
    notifyListeners();

    refresh();
    notifyListeners();

  }





}