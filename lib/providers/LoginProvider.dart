import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sharedprefrences/usershare.dart';

class LoginShared {
  //
  // String _ID="";
  // String _fnem="";
  // String _lnem="";
  // String _mail= "";
  // String _phon="";
  // String _loc="";
  // String _pic="";
  // String _pass="";
  // String _con="";
  // String _date="";
  //
  // String get ID =>_ID;
  // String get fnem => _fnem;
  // String get lnem => _lnem;
  // String get mail => _mail;
  // String get phon => _phon;
  // String get loc => _loc;
  // String get pic => _pic;
  // String get pass => _pass;
  // String get con => _con;
  // String get date => date;


Future<void>  savePref(String ID, String fnem, String lnem, String mail, String phon,
      String loc, String pic, String pass,
      String con, String date) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(PrefInfo.id, ID);
    sharedPreferences.setString(PrefInfo.fnem, fnem);
    sharedPreferences.setString(PrefInfo.lnem, lnem);
    sharedPreferences.setString(PrefInfo.mail, mail);
    sharedPreferences.setString(PrefInfo.phon, phon);
    sharedPreferences.setString(PrefInfo.loc, loc);
    sharedPreferences.setString(PrefInfo.phot, pic);
    sharedPreferences.setString(PrefInfo.pass, pass);
    sharedPreferences.setString(PrefInfo.count, con);
    sharedPreferences.setString(PrefInfo.create, date);


  }


  Future <void> getPref(String? ID, String? fnem, String? lnem, String? mail, String? phon,
      String? loc, String? pic, String? pass,
      String? con, String? date)async {
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ID=sharedPreferences.getString(PrefInfo.id);
    fnem=sharedPreferences.getString(PrefInfo.fnem);
    lnem=sharedPreferences.getString(PrefInfo.lnem);
    mail=sharedPreferences.getString(PrefInfo.mail);
    phon =sharedPreferences.getString(PrefInfo.phon);
    loc=sharedPreferences.getString(PrefInfo.loc);
    pic =sharedPreferences.getString(PrefInfo.phot);
    pass=sharedPreferences.getString(PrefInfo.pass);
    con=sharedPreferences.getString(PrefInfo.count);
    date=sharedPreferences.getString(PrefInfo.create);


  }



  Future <void> getID(String? ID) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ID=sharedPreferences.getString(PrefInfo.id);
  }



Future<void>  LogOut()async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(PrefInfo.id);
  sharedPreferences.remove(PrefInfo.fnem);
  sharedPreferences.remove(PrefInfo.lnem);
  sharedPreferences.remove(PrefInfo.mail);
  sharedPreferences.remove(PrefInfo.phon);
  sharedPreferences.remove(PrefInfo.loc);
  sharedPreferences.remove(PrefInfo.phot);
  sharedPreferences.remove(PrefInfo.pass);
  sharedPreferences.remove(PrefInfo.count);
  sharedPreferences.remove(PrefInfo.create);

}


}
