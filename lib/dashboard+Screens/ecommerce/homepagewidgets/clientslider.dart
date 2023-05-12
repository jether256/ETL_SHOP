import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../theme/themenotifier.dart';
import '../slider&productsjson/clientjson.dart';

class ClientSlider extends StatefulWidget {
  const ClientSlider({Key? key}) : super(key: key);

  @override
  State<ClientSlider> createState() => _ClientSliderState();
}

class _ClientSliderState extends State<ClientSlider> {



  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = client_json;
      itemLength = client_json.length;
    });

  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:itemLength,
          itemBuilder: (BuildContext context, int index) {

            return  Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
              child: Container(
                 width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),

                      color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.white10
                  ),
                  child:Image.asset(itemsTemp[index]['img'],fit: BoxFit.cover,)),
            );


          },),
      ),
    );
  }
}

