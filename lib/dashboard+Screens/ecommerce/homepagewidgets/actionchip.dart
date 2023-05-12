import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../theme/themenotifier.dart';
import '../slider&productsjson/categoryjson.dart';

class ActionCategory extends StatefulWidget {
  const ActionCategory({Key? key}) : super(key: key);

  @override
  State<ActionCategory> createState() => _ActionCategoryState();
}

class _ActionCategoryState extends State<ActionCategory> {

  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = cat_json;
      itemLength = cat_json.length;
    });
  }



  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);


    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: Colors.white,
      child:Container(
        child: Row(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:itemLength,
              itemBuilder: (BuildContext context, int index) {

                return  ActionChip(
                    label:Text(itemsTemp[index]['name'],maxLines: 2),
                  onPressed:(){

                      EasyLoading.showSuccess('${itemsTemp[index]['name']} clicked');
                  },
                );


              },),
          ],
        ),
      ) ,
    );
  }
}
