
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
        appBar:AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title:const Text('Manage Cards',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
          actions: [

            InkWell(
              onTap: (){

              },
              child:const Icon(Icons.add_circle_outline,color: Colors.white,),
            ),



          ],
        ),
        body:ListView(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          children: [



          ],
        ),
      ),
    );
  }
}
