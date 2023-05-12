
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../productdetail/productdetail.dart';
import '../slider&productsjson/productjson.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {

  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = pro_json;
      itemLength = pro_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);



    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child:GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount:itemLength,
        gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2/3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10
        ),
        itemBuilder: (BuildContext context, int index) {
          return  InkWell(
            onTap: (){

              //route to issue details page with its elements
              // Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
              //     img:itemsTemp[index]['img'],name:itemsTemp[index]['name'],de:itemsTemp[index]['de'],price:itemsTemp[index]['price'],man:itemsTemp[index]['man'],
              //     modo:itemsTemp[index]['modo'],ava:itemsTemp[index]['ava']
              // )));


            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8),
              child: Container(
                alignment: Alignment.bottomLeft,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                ),
                child:Column(
                  children: [

                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Hero(
                          tag:'pro-${itemsTemp[index]['img']}',
                          child:Image.asset(itemsTemp[index]['img'],fit: BoxFit.cover,)
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,

                        children: [

                          Container(

                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color:themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
                              borderRadius: BorderRadius.circular(4),
                              //border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                            ),
                            child: Column(
                              children: [
                                Text(itemsTemp[index]['name'],maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Text('Shs: ${itemsTemp[index]['price']}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.white),),
                                //Text(forma,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ) ,
              ),
            ),
          );


        },),
    );
  }
}
