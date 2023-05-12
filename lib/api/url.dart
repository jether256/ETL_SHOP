
class BaseUrl{
  static String address = "holomboko.000webhostapp.com";

  //authentication
  static String apiRegister = "https://$address/api/log/register.php";
  static String regVerify = "https://$address/api/log/verify.php";

  static String checkMail = "https://$address/api/log/checkmail.php";
  static String passVerify = "https://$address/api/log/verifyPass.php";

  static String apiLogin = "https://$address/api/log/login.php";

  ///categories and subcategories
  static String category = "https://$address/api/cat/category.php";
  static String subCategory = "https://$address/api/subcat/subcat.php";


  ///products
  static String getProduct = "https://$address/api/product/product.php";
  static String getProductFeatured = "https://$address/api/product/featuredpro.php";
  static String getProductCategory = "https://$address/api/product/probycategory.php";
  static String getProductSubCategory = "https://$address/api/product/probysubcategory.php";
  static String getPartners = "https://$address/api/partners/partner.php";


  ///shopping cart
  static String addToCart = "https://$address/api/cart/addtocart.php";
  static String getCarttt = "https://$address/api/cart/getCart.php";
  static String updateCart = "https://$address/api/cart/updateCart.php";
  static String deleteCart = "https://$address/api/cart/deleteCart.php";
  static String getTotalPrice = "https://$address/api/cart/getTotalCart.php";
  static String getTotoP = "https://$address/api/cart/toto.php";
  static String cartCount = "https://$address/api/cart/cartCount.php";
  static String shipping = "https://$address/api/cart/shipping.php";
  static String shipCheck = "https://$address/api/cart/shipCheck.php";
  static String checkOut = "https://$address/api/cart/checkOut.php";

  ///orders
  //static String myOd = "https://$address/api/orders/orders.php";
  static String myOd = "https://$address/api/orders/getOrders.php";
  static String myOdDetails = "https://$address/api/orders/getOrderDetails.php";
  static String getOderNoti = "https://$address/api/orders/getOrderNoti.php";
  static String getOderNotiCount = "https://$address/api/orders/getOdNotiCount.php";
  static String updateNoti = "https://$address/api/orders/updateNoti.php";


  ///favourites
  static String addFav = "https://$address/api/cart/addfav.php";
  static String getFav = "https://$address/api/cart/getFav.php";
  static String delFav = "https://$address/api/cart/deleteFav.php";

  ///search and pass reset
  static String passReset = "https://$address/api/log/passReset.php";
  static String searchPro = "https://$address/api/product/search.php";





}