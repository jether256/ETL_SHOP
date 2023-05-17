
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/url.dart';
import '../../../providers/featuredprovider.dart';
import '../../../providers/productprovider.dart';
import '../../../theme/themenotifier.dart';
import '../productdetail/productdetail.dart';

class Featured extends StatefulWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {

  final _formated= NumberFormat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<FeaturedProvider>(context,listen: false).getAllFeatured();
    });
  }


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height:255,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey.shade400: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child:Consumer<FeaturedProvider>(
        builder: (context,value,child){

          final pros=value.fea;

          //if loading return a list of loading gifs
          if(value.isLoading){

            return ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300,
                      ),
                      child:Image.asset(
                        'assets/images/hug.gif',
                        height: 235,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }

          return ListView.builder(
              itemCount: pros.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {


                var offer=(double.parse(pros[index].regp) - double.parse(pros[index].selp)) /double.parse(pros[index].regp) * 100;

                var s_price=int.parse(pros[index].selp);
                String sprice=_formated.format(s_price);

                var r_price=int.parse(pros[index].regp);
                String rprice=_formated.format(r_price);

                return InkWell(
                  onTap: (){



                    //route to product details page with its elements
                    Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
                      id:pros[index].id,nem:pros[index].nem,regp:pros[index].regp,selp:pros[index].selp,catid:pros[index].catid,disr:pros[index].disr,ratin:pros[index].ratin,
                      im1:pros[index].im1,im2:pros[index].im2,im3:pros[index].im3,manid:pros[index].manid,storeid:pros[index].storeid,ava:pros[index].ava,desc:pros[index].desc,
                      promoid:pros[index].promoid, create:pros[index].create,subid:pros[index].subid,modoid:pros[index].modoid,fe:pros[index].fe,retun:pros[index].retun,
                      psdec:pros[index].psdec,end:pros[index].end,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
                      ),
                      child:Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child:CachedNetworkImage(
                                imageUrl:'https://${BaseUrl.imUrl}${pros[index].im1}',
                                //imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${pros[index].im1}',
                                //imageUrl:'https://www.etl.co.ug/assets/images/products/${pros[index].im1}',
                                height: 180,
                                width: 220,
                                fit: BoxFit.cover,
                              ) ,
                            ),
                          ),

                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:Colors.transparent,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${offer.toStringAsFixed(0)} % OFF",style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Featured",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: pros[index].nem,
                                            style: TextStyle(color:themeProvider.isDarkMode ? Colors.white: Colors.black)
                                        ),
                                        TextSpan(
                                            text: " ${pros[index].ava}",
                                            style: TextStyle(color:themeProvider.isDarkMode ? Colors.white: Colors.black)
                                        )
                                      ],
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Shs ${sprice}',
                                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16
                                        ),
                                      ),
                                      const SizedBox(width:20),
                                      Text(
                                        'Shs ${rprice}',
                                        style: const TextStyle(decoration: TextDecoration.lineThrough
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
