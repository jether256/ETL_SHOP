import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../theme/theme.dart';
class AddtoCart extends StatefulWidget {

  const AddtoCart({Key? key}) : super(key: key);

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: ()
      async {

        EasyLoading.showSuccess('Added to cart');

      },

      child:Container(
        height:56 ,
        decoration: BoxDecoration(
          color:mainColor,
        ),
        child: Center(child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.cart,color: Colors.white,),
            SizedBox(width: 4,),
            Text('Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
        ),
      ),
    );
  }
}
