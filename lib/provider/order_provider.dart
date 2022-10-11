import 'package:admin_app/http/custom_http_request.dart';
import 'package:admin_app/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

//What is mixin class in flutter?(Interview Question)
class OrderProvider with ChangeNotifier {
  
  List <OrderModel> orderList = [];
  late OrderModel orderModel;

  getOrders() async{
    orderList=await CustomHttpRequest().getAllOrders();
    notifyListeners();
  }
}