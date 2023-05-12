import 'package:edge_app/providers/catprovider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../theme/themenotifier.dart';
import '../category&subcategorymore/catmore.dart';


class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

  Provider.of<CategoriesProvider>(context,listen: false).getAllCats();
});

  }


  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey.shade400: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child:Consumer<CategoriesProvider>(
            builder: (context,value,child){

              final cats=value.categs;

              if(value.isLoading){

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {

                    return  Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                      child: Container(
                        width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),

                              color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300
                          ),
                        child:Image.asset('assets/images/hug.gif',height:20,width: 90,) ,
                         ),
                    );


                  },);

              }else if(value.noNet){

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          return  Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),

                                  color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300
                              ),
                              child:Image.asset('assets/images/lost2.gif',height:20,width: 90,fit: BoxFit.cover,) ,
                            ),
                          );


                        },);

              }

            return  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:cats.length,
                itemBuilder: (BuildContext context, int index) {

                  return  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                    child: Container(
                      // width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),

                            color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.white10
                        ),
                        child:ActionChip(
                          label:Text(cats[index].nem,maxLines: 2),
                          onPressed:(){



                            //route to product details page with its elements
                            Navigator.push(context,MaterialPageRoute(builder:(context) => CategoryMore(
                              id:cats[index].id,nem:cats[index].nem,
                            )));

                            //EasyLoading.showSuccess('Category clicked');
                          },
                        )),
                  );


                },);

            },
      ),
    );
  }
}
