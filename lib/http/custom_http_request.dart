
import 'dart:convert';

import 'package:admin_app/model/category_model.dart';
import 'package:admin_app/model/order_model.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomHttpRequest{
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

SharedPreferences ? sharedPreferences;

Future <Map<String,String>> getHeaderWithToken()async{
  sharedPreferences = await SharedPreferences.getInstance();
  var header = {
    "Accept": "application/json",
    "Authorization":
        "bearer ${sharedPreferences!.getString("token")}",
   };
   print("Token is ${sharedPreferences!.getString("token")}");
   return header;
 }

 String allorderLink="https://apihomechef.antopolis.xyz/api/admin/all/orders";
   Future <dynamic> getAllOrders() async {
     List <OrderModel> orderList=[];
   late OrderModel orderModel;
    var responce = await http.get(Uri.parse(allorderLink),
    headers: await CustomHttpRequest().getHeaderWithToken()
    );
    if(responce.statusCode == 200){
      var item = jsonDecode(responce.body);
      print("$item");
      for(var data in item){
        orderModel=OrderModel.fromJson(data);
          orderList.add(orderModel);
      }
      print("Total Order is ${orderList.length}"); 
    }
    return  orderList;
  }
   String allCategoryLink="https://apihomechef.antopolis.xyz/api/admin/category"; 
   Future <dynamic> getAllCategory() async {
     List <CategoryModel> categoryList=[];
   late CategoryModel categoryModel;
    var responce = await http.get(Uri.parse(allCategoryLink),
    headers: await CustomHttpRequest().getHeaderWithToken()
    );
    if(responce.statusCode == 200){
      var item = jsonDecode(responce.body);
      print("$item");
      for(var data in item){
        categoryModel=CategoryModel.fromJson(data);
          categoryList.add(categoryModel);
      }
      print("Total Order is ${categoryList.length}"); 
    }
    return  categoryList;
  }

  static Future <dynamic> deleteCategory(int id) async {
    var responce=await http.delete(Uri.parse("https://apihomechef.antopolis.xyz/api/admin/category/$id/delete"),
    headers: await CustomHttpRequest().getHeaderWithToken()
    );

    if(responce.statusCode==200){
      showInToast("Category Item Deleted Successfully");
    }
    else{
      showInToast("Please Try Again");
    }
    
  } 
}